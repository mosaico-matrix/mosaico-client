import 'package:flutter/material.dart';
import 'package:mosaico/shared/widgets/mosaico_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';

import '../../../../core/configuration/routes.dart';

class SlideshowTile extends StatelessWidget {

  final MosaicoSlideshow slideshow;
  const SlideshowTile({super.key, required this.slideshow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.slideshow, arguments: slideshow),
      child: const MosaicoTile(
        child: ListTile(
          title: Text("data"),
      )),
    );
  }
}
