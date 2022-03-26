import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_state.dart';
import 'package:t_photos/base/bloc/navigator/base_navigator_bloc.dart';
import 'package:t_photos/bloc/nav/timeline_nav_bloc/timeline_nav_event.dart';
import 'package:t_photos/bloc/nav/timeline_nav_bloc/timeline_nav_state.dart';

class TimelineNavigatorBloc extends BaseNavigatorBloc {
  TimelineNavigatorBloc() : super(const TimelineNavigatorStateInitial()) {
    on<TimelineNavigatorEventShowImageDetails>(_openDetailScreen);
  }

  void _openDetailScreen(
      TimelineNavigatorEventShowImageDetails
          timelineNavigatorEventShowImageDetails,
      Emitter<BaseNavigatorState> emitter) {
    emitter(TimelineNavigatorStateShowFullPicture(
        timelineNavigatorEventShowImageDetails.photoListItem));
  }
}
