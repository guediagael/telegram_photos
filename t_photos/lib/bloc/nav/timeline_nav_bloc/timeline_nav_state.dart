import 'package:t_photos/base/bloc/navigator/base_nav_state.dart';
import 'package:t_photos/ui_models/photo_list_item.dart';

class TimelineNavigatorStateInitial extends BaseNavigatorState {
  const TimelineNavigatorStateInitial() : super(const []);
}

class TimelineNavigatorStateShowFullPicture extends BaseNavigatorState {
  final PhotoListItem item;

  TimelineNavigatorStateShowFullPicture(this.item) : super([item]);
}
