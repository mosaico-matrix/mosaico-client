import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/material.dart';

class MosaicoWidgetImagesCarousel extends StatelessWidget {
  final List<String>? images;

  const MosaicoWidgetImagesCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) {
      return Container();
    }

    return CarouselImages(
      scaleFactor: 0.8,
      listImages: images!,
      height: 200.0,
      borderRadius: 10.0,
      cachedNetworkImage: true,
      verticalAlignment: Alignment.topCenter,
    );

  }
}
