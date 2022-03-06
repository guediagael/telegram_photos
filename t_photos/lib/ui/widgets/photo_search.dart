import 'package:flutter/material.dart';
import 'package:t_photos/ui_models/photo_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoSearchWidget extends StatelessWidget {
  final PhotoListItem photoListItem;

  const PhotoSearchWidget({Key? key, required this.photoListItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: photoListItem.hashCode,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: "http://via.placeholder.com/200x150", //TODO
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.red, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          ],
        ));
  }
}
