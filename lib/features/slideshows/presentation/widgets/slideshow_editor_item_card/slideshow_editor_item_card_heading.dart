import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_item_cubit.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:provider/provider.dart';

class SlideshowEditorItemCardHeading extends StatelessWidget {
  final int position;
  const SlideshowEditorItemCardHeading({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Text(
        style: const TextStyle(fontSize: 20), "Widget ${position + 1}");
  }
}
