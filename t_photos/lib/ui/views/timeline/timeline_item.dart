import 'package:flutter/material.dart';
import 'package:t_photos/ui/widgets/photo_search.dart';
import 'package:t_photos/ui_models/photo_list_item.dart';

class TimelineItem extends StatefulWidget {
  final PhotoListItem photoListItem;
  final Function onLongPressed;
  final Function onPressed;
  final bool isSelectionActivated;
  final bool? isSelected;

  const TimelineItem(
      {Key? key,
      required this.photoListItem,
      required this.onLongPressed,
      required this.onPressed,
      this.isSelectionActivated = false,
      this.isSelected})
      : assert((isSelectionActivated == false && isSelected == null) ||
            (isSelectionActivated == true && isSelected != null)),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  @override
  void initState() {
    if (widget.isSelected ?? false) debugPrint("This is selected");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        debugPrint("timelineItem:: long pressed ${widget.photoListItem}");
        widget.onLongPressed();
      },
      onTap: () {
        debugPrint("timelineItem:: pressed ${widget.photoListItem}");
        if (widget.isSelectionActivated) {
          widget.onLongPressed();
        } else {
          widget.onPressed();
        }
      },
      child: _getBody(),
    );
  }

  Widget _getBody() {
    debugPrint(
        'Selection activated ${widget.isSelectionActivated} and '
            'is selected ${widget.isSelected}');
    if (!widget.isSelectionActivated) {
      return PhotoSearchWidget(photoListItem: widget.photoListItem);
    }
    return Stack(
      children: [
        Center(child: PhotoSearchWidget(photoListItem: widget.photoListItem)),
        Positioned(
            child: widget.isSelected!
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 16,
                  )
                : const Icon(
                    Icons.circle_outlined,
                    size: 16,
                  ))
      ],
    );
  }
}
