import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/data/base_data_bloc.dart';
import 'package:t_photos/base/bloc/data/base_state.dart';
import 'package:t_photos/bloc/data/timeline/timeline_event.dart';
import 'package:t_photos/bloc/data/timeline/timeline_state.dart';
import 'package:t_photos/data/data_manager_api.dart';
import 'package:t_photos/ui_models/photo_list_item.dart';

class TimelineBloc extends BaseBloc {
  final DataManagerApi _dataManagerApi;

  TimelineBloc(this._dataManagerApi) : super(const TimelineStateInitial()) {
    on<TimelineEventLoad>(_loadTimeline);
    on<TimelineEventDeletePicture>(_deletePicture);
    on<TimelineEventOnItemLongPress>(_imagesSelected);
  }

  void _loadTimeline(TimelineEventLoad eventLoad, Emitter<BaseState> emitter) {
    final groupedItems = generateMockList();
    DateTime lastDate = DateTime.now().subtract(const Duration(days: 5));
    emitter(TimelineStateLoaded(
        prevLastDate: lastDate, groupedPhotos: groupedItems));
  }

  void _deletePicture(TimelineEventDeletePicture eventDeletePicture,
      Emitter<BaseState> emitter) {
    final oldGroupedList = eventDeletePicture.loadedList;
    var newGroupedList = <String, List<PhotoListItem>>{};
    for (var key in oldGroupedList.keys) {
      var oldList = oldGroupedList[key];
      var newList = oldList!.where((element) =>
      !eventDeletePicture.photoItemsToDelete.contains(element));
      newGroupedList[key] = newList.toList(growable: false);
    }

    DateTime prevDate = DateTime.now().subtract(const Duration(days: 5));

    emitter(TimelineStatePhotoDeleted(
        prevLastDate: prevDate, groupedPhotos: newGroupedList));
  }

  void _imagesSelected(TimelineEventOnItemLongPress onItemLongPress,
      Emitter<BaseState> emitter) {
    final oldSelection = onItemLongPress.selectedPhotos;
    var newSelections = <PhotoListItem>[];
    if (oldSelection == null || oldSelection.isEmpty) {
      newSelections.add(onItemLongPress.newSelection);
    } else {
      newSelections.addAll(oldSelection);
      if (oldSelection.contains(onItemLongPress.newSelection)) {
        newSelections.remove(onItemLongPress.newSelection);
      } else {
        newSelections.add(onItemLongPress.newSelection);
      }
    }
    if (newSelections.isNotEmpty) {
      emitter(TimelineStatePhotoSelected(
          selectedPhotos: newSelections,
          loadedList: onItemLongPress.loadedList));
    } else {
      DateTime lastDate = DateTime.now().subtract(const Duration(days: 5));
      emitter(TimelineStateLoaded(
          prevLastDate: lastDate, groupedPhotos: onItemLongPress.loadedList));
    }
  }

  static Map<String, List<PhotoListItem>> generateMockList() {
    DateTime start = DateTime.now().subtract(const Duration(days: 4));
    DateTime end = DateTime.now();

    final groupedItems = <String, List<PhotoListItem>>{};
    var dayDiff = end
        .difference(start)
        .inDays;
    while (dayDiff > 0) {
      final items = <PhotoListItem>[];
      final date = DateTime.now().add(Duration(days: dayDiff));
      for (int i = 0; i < 5; i++) {
        var item = PhotoListItem(
            uri:
            "${date.toString()}$i${Random(3).nextDouble()}randomuri${Random(2)
                .nextInt(10)}",
            date: date);
        items.add(item);
      }
      groupedItems["${date.year}/${date.month}/${date.day}"] = items;

      dayDiff--;
    }
    return groupedItems;
  }
}
