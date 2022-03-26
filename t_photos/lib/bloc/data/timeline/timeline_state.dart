import 'package:t_photos/base/bloc/data/base_state.dart';
import 'package:t_photos/ui_models/photo_list_item.dart';

class TimelineState extends BaseState {
  const TimelineState(List<Object?> properties) : super(properties);
}

class TimelineStateInitial extends TimelineState {
  const TimelineStateInitial() : super(const []);
}

class TimelineStateLoaded extends TimelineState {
  final DateTime prevLastDate;
  final Map<String, List<PhotoListItem>> groupedPhotos;

  TimelineStateLoaded({required this.prevLastDate, required this.groupedPhotos})
      : super([prevLastDate, groupedPhotos]);
}

class TimelineStatePhotoDeleted extends TimelineState {
  final DateTime prevLastDate;
  final Map<String, List<PhotoListItem>> groupedPhotos;

  TimelineStatePhotoDeleted(
      {required this.prevLastDate, required this.groupedPhotos})
      : super([prevLastDate, groupedPhotos]);
}

class TimelineStatePhotoSelected extends TimelineState {
  final List<PhotoListItem> selectedPhotos;
  final Map<String, List<PhotoListItem>> loadedList;

  TimelineStatePhotoSelected(
      {required this.selectedPhotos, required this.loadedList})
      : super([selectedPhotos, loadedList]);
}
