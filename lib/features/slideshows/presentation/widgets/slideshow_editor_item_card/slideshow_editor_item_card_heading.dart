import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_item_cubit.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:provider/provider.dart';

class SlideshowEditorItemCardHeading extends StatelessWidget {
  const SlideshowEditorItemCardHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MosaicoSlideshowItemCubit, MosaicoSlideshowItem>(
      builder: (context, state) {
        return Text(
            style: const TextStyle(fontSize: 20),
            "Widget ${state.position+1}");
      },
    );
  }
}
