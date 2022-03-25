import 'dart:math';

import 'package:flutter/material.dart';
import 'package:t_photos/ui/widgets/photo_search.dart';
import 'package:t_photos/ui_models/photo_list_item.dart';

class TimelineScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    final items = PhotoListItem.generateMockList();
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        primary: false,
        slivers: _getSlivers(items),
      ),
    );
  }

  List<Widget> _getSlivers(Map<String, List<PhotoListItem>> groupedItems) {
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
            return Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: PhotoSearchWidget(
                    key: Key("${Random(5).toString()}"),
                    photoListItem: photos[index]),
              ),
            );
          }),
        ),
      ));
    }
    return slivers;
  }
}
