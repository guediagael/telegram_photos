import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/data/base_bloc_builder.dart';
import 'package:t_photos/base/bloc/data/base_bloc_listener.dart';
import 'package:t_photos/base/bloc/data/base_state.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_builder.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_listener.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_state.dart';
import 'package:t_photos/bloc/data/timeline/timeline_bloc.dart';
import 'package:t_photos/bloc/data/timeline/timeline_event.dart';
import 'package:t_photos/bloc/data/timeline/timeline_state.dart';
import 'package:t_photos/bloc/nav/timeline_nav_bloc/timeline_nav_bloc.dart';
import 'package:t_photos/bloc/nav/timeline_nav_bloc/timeline_nav_state.dart';
import 'package:t_photos/data/data_manager_impl.dart';
import 'package:t_photos/ui/views/timeline/timeline_item.dart';
import 'package:t_photos/ui/views/timeline/timeline_selection_floating_button.dart';
import 'package:t_photos/ui_models/photo_list_item.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimeLineScreenState();

  static Widget buildTimelineScreen(BuildContext context) {
    final dataManager = DataManagerImpl.getInstance();
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => TimelineNavigatorBloc()),
      BlocProvider(create: (_) => TimelineBloc(dataManager))
    ], child: const TimelineScreen());
  }
}

class _TimeLineScreenState extends State<TimelineScreen> {
  late final TimelineNavigatorBloc _navigatorBloc;
  late final TimelineBloc _bloc;

  @override
  void initState() {
    _navigatorBloc = BlocProvider.of<TimelineNavigatorBloc>(context);
    _bloc = BlocProvider.of<TimelineBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc.add(TimelineEventLoad(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return BaseNavigatorBlocListener(
      bloc: _navigatorBloc,
      navListener: (navContext, navState) {
        if (navState is TimelineNavigatorStateShowFullPicture) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const Text("Details")));
        }
      },
      child: BaseNavigatorBlocBuilder(
        bloc: _navigatorBloc,
        buildWhenCondition: (prevState, currentState) {
          return (prevState != currentState) ||
              (currentState is! TimelineNavigatorStateShowFullPicture);
        },
        navigatorBlocWidgetBuilder:
            (BuildContext context, BaseNavigatorState state) {
          return BaseBlocListener(
            bloc: _bloc,
            navigatorBloc: _navigatorBloc,
            listener: (context, state) {
              debugPrint("timelinescreen::bloclistener $state");
              //TODO add states related to messages/prompts
              if (state is TimelineStateInitial) {
                _bloc.add(TimelineEventLoad(DateTime.now()));
              }
            },
            child: BaseBlocBuilder(
              bloc: _bloc,
              buildWhenCondition: (prevState, currentState) {
                return (prevState != currentState) ||
                    (currentState is TimelineStateInitial);
              },
              builder: (BuildContext context, BaseState state) {
                return Scaffold(
                  body: CustomScrollView(
                    shrinkWrap: true,
                    primary: false,
                    slivers: _getSlivers(state as TimelineState),
                  ),
                  floatingActionButton: (state is TimelineStatePhotoSelected)
                      ? SelectedPhotosMenu(
                          count: state.selectedPhotos.length,
                          onCancel: () {
                            _bloc.add(TimelineEventOnCancelSelections(
                                state.loadedList));
                          },
                          onDelete: () {
                            _bloc.add(TimelineEventDeletePicture(
                                photoItemsToDelete: state.selectedPhotos,
                                loadedList: state.loadedList));
                          },
                        )
                      : null,
                );
              },
            ),
          );
        },
      ),
    );
  }

  List<Widget> _getSlivers(TimelineState state) {
    late Map<String, List<PhotoListItem>> groupedItems;

    late List<PhotoListItem>? selectedItems = null;
    if (state is TimelineStateInitial) {
      return [
        const SliverToBoxAdapter(
          child: Text("Loading..."),
        )
      ];
    } else if (state is TimelineStateLoaded) {
      groupedItems = state.groupedPhotos;
    } else if (state is TimelineStatePhotoDeleted) {
      groupedItems = state.groupedPhotos;
    } else if (state is TimelineStatePhotoSelected) {
      groupedItems = state.loadedList;
      selectedItems = state.selectedPhotos;
    }

    if (kDebugMode) {
      if (state is TimelineStatePhotoSelected) {
        debugPrint("timeline showing selected :$selectedItems");
      }
    }
    var slivers = <Widget>[];
    for (var date in groupedItems.keys) {
      final photos = groupedItems[date]!;
      slivers.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 4),
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Text(date),
          ),
        ),
      ));
      slivers.add(SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: List<Card>.generate(photos.length, (index) {
            final photo = photos[index];
            final bool? isSelected = selectedItems?.contains(photo);
            if (kDebugMode) {
              if (isSelected ?? false) print("Selected $photo");
            }
            return Card(
              elevation: 4,
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: TimelineItem(
                    photoListItem: photo,
                    isSelectionActivated: state is TimelineStatePhotoSelected,
                    isSelected: isSelected,
                    onPressed: () {
                      debugPrint("photo pressed ${photos[index]}");
                    },
                    onLongPressed: () {
                      debugPrint("photo long pressed ${photos[index]}");
                      _bloc.add(TimelineEventOnItemLongPress(
                          selectedPhotos: selectedItems,
                          loadedList: groupedItems,
                          newSelection: photos[index]));
                    },
                  )),
            );
          }),
        ),
      ));
    }
    return slivers;
  }
}
