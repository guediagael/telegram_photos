import 'package:t_photos/base/bloc/data/base_event.dart';
import 'package:t_photos/ui_models/photo_list_item.dart';

class TimelineEvent extends BaseEvent {
  const TimelineEvent(List<Object?> properties) : super(properties);
}

class TimelineEventLoad extends TimelineEvent {
  final DateTime initialDate;

  TimelineEventLoad(this.initialDate) : super([initialDate]);
}

class TimelineEventDeletePicture extends TimelineEvent {
  final List<PhotoListItem> photoItemsToDelete;
  final Map<String, List<PhotoListItem>> loadedList;

  TimelineEventDeletePicture(
      {required this.photoItemsToDelete, required this.loadedList})
      : super([photoItemsToDelete, loadedList]);
}

class TimelineEventOnItemLongPress extends TimelineEvent {
  final PhotoListItem newSelection;
  final List<PhotoListItem>? selectedPhotos;
  final Map<String, List<PhotoListItem>> loadedList;

  TimelineEventOnItemLongPress(
      {this.selectedPhotos,
      required this.loadedList,
       required this.newSelection})
      : super([selectedPhotos, loadedList]);
}
