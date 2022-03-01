import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_builder.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_listener.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_event.dart';
import 'package:t_photos/bloc/nav/main_nav_bloc/main_nav_bloc.dart';
import 'package:t_photos/bloc/nav/main_nav_bloc/main_nav_event.dart';
import 'package:t_photos/bloc/nav/main_nav_bloc/main_nav_state.dart';
import 'package:t_photos/ui_models/dialog_item_choice.dart';
import 'package:t_photos/views/search/search.dart';
import 'package:t_photos/views/settings/settings.dart';
import 'package:t_photos/views/timeline/timeline.dart';
import 'package:t_photos/widgets/dialogs/dialog_choice.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // late int _currentTab;
  late final MainNavigatorBloc _mainNavigatorBloc;

  @override
  void initState() {
    // _currentTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _mainNavigatorBloc = BlocProvider.of<MainNavigatorBloc>(context);
    return BaseNavigatorBlocListener(
      bloc: _mainNavigatorBloc,
      navListener: (ctx, state) {
        if (state is MainNavigatorStateShowSettings) {
          _showSettings();
        } else if (state is MainNavigatorStateShowAddDialog) {
          _showAddDialog();
        } else if (state is MainNavigatorStateOpenGallery) {
          _openGallery();
        } else if (state is MainNavigatorStateOpenCamera) {
          _openCamera();
        }
      },
      child: BaseNavigatorBlocBuilder(
        bloc: _mainNavigatorBloc,
        buildWhenCondition: (prevState, currentState) {
          return (currentState != prevState) &&
              (currentState is! MainNavigatorStateShowSettings) &&
              (currentState is! MainNavigatorStateShowAddDialog) &&
              (currentState is! MainNavigatorStateOpenGallery) &&
              (currentState is! MainNavigatorStateOpenCamera);
        },
        navigatorBlocWidgetBuilder: (navBlocCtx, navState) {
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      _mainNavigatorBloc
                          .add(const MainNavigatorEventShowSettings());
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            body: IndexedStack(
              index: (navState is MainNavigatorStateShowTimeLine) ? 0 : 1,
              children: [TimelineScreen(), SearchScreen()],
            ),
            // body: Route(),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.timer), label: "Timeline"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
              ],
              currentIndex:
                  (navState is MainNavigatorStateShowTimeLine) ? 0 : 1,
              onTap: (index) {
                _mainNavigatorBloc.add((index == 0)
                    ? const MainNavigatorEventShowTimeLine([])
                    : const MainNavigatorEventShowSearch([]));
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                _mainNavigatorBloc.add(const MainNavigatorEventAddNew());
              },
            ),
          ));
        },
      ),
    );
  }

  void _showSettings() {
    debugPrint("Showing settings");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
    // showModalBottomSheet(
    //     context: context,
    //     builder: (ctx) {
    //       return const SettingsScreen();
    //     });
  }

  void _showAddDialog() {
    debugPrint("Showing add dialog");
    showDialog(
        context: context,
        builder: (ctx) => DialogChoice(choices: [
              DialogItemChoice("Gallery", () {
                if (kDebugMode) {
                  print("Show gallery");
                }
              }),
              DialogItemChoice("Camera", () {
                if (kDebugMode) {
                  print("Show camera");
                }
              }),
            ], title: "Upload picture from"));
  }

  void _openGallery() {
    debugPrint("opening gallery");
    _mainNavigatorBloc.add(BaseNavigatorEventPop(_mainNavigatorBloc.state));
  }

  void _openCamera() {
    debugPrint("opening Camera");
    _mainNavigatorBloc.add(BaseNavigatorEventPop(_mainNavigatorBloc.state));
  }
}
