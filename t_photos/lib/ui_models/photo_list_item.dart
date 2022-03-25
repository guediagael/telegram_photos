import 'dart:math';

import 'package:t_photos/extension/list_extension.dart';

class PhotoListItem {
  final String uri;
  final DateTime date;
  final StringList? tags;
  final double? latitude, longitude;

  PhotoListItem(
      {required this.uri,
      required this.date,
      this.tags,
      this.longitude,
      this.latitude})
      : assert((latitude == null && longitude == null) ||
            (longitude != null && latitude != null));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoListItem &&
          runtimeType == other.runtimeType &&
          uri == other.uri &&
          date == other.date &&
          tags == other.tags &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      uri.hashCode ^
      date.hashCode ^
      tags.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;

  static Map<String,List<PhotoListItem>> generateMockList() {
    DateTime start = DateTime.now().subtract(const Duration(days: 4));
    DateTime end = DateTime.now();

    final groupedItems = <String,List<PhotoListItem>>{};
    var dayDiff = end.difference(start).inDays;
    while (dayDiff > 0) {
      final items = <PhotoListItem>[];
      final date = DateTime.now().add(Duration(days: dayDiff));
      for (int i=0; i<5;i++) {
        var item = PhotoListItem(
            uri: "${date.toString()}$i${Random(3).nextDouble()}randomuri${Random(2).nextInt(10)}",
            date: date);
        items.add(item);
      }
      groupedItems["${date.year}/${date.month}/${date.day}"] = items;

      dayDiff--;
    }
    return groupedItems;
  }

  @override
  String toString() {
    return 'PhotoListItem{uri: $uri, date: $date, latitude: $latitude, longitude: $longitude}';
  }
}
