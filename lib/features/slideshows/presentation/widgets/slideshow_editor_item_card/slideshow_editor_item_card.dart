import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_item_cubit.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_editor_item_card/slideshow_editor_item_card_config_select.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:provider/provider.dart';

import 'slideshow_editor_item_card_duration.dart';
import 'slideshow_editor_item_card_heading.dart';
import 'slideshow_editor_item_card_widget_select.dart';

class SlideshowEditorItemCard extends StatelessWidget {
  final MosaicoSlideshowItem slideshowItem;

  const SlideshowEditorItemCard({super.key, required this.slideshowItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: MosaicoSlideshowItemCubit(
            slideshowCubit: context.read(), initialState: slideshowItem),
          child:  Stack(children: [
            _buildCard(
                child: const Column(
                  children: [
                    SlideshowEditorItemCardHeading(),
                    SlideshowEditorItemCardWidgetSelect(),
                    SlideshowEditorItemCardConfigSelect(),
                    SlideshowEditorItemCardDuration(),
                  ],
                ),
                context: context),
            _buildDeleteButton(context),
          ]),
    );
  }

  Widget _buildCard({required Widget child, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            decoration: BoxDecoration(
              border: GradientBoxBorder(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Colors.white.withOpacity(0.6)
                    ]),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: () {
            context
                .read<MosaicoSlideshowCubit>()
                .removeSlideshowItem(slideshowItem);
          },
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error),
    );
  }

  Widget _buildUpButton(BuildContext context) {
    // Build only if not the first item
    if (slideshowItem.position == 0) {
      return const SizedBox();
    }

    return Positioned(
      left: 0,
      top: 0,
      child: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: () {},
          icon: const Icon(Icons.arrow_upward),
          color: Theme.of(context).colorScheme.secondary),
    );
  }

  Widget _buildDownButton(BuildContext context) {
    // Build only if not the last item and there are more than 1 items
    if (slideshowItem.position ==
            context.read<MosaicoSlideshowCubit>().state.items.length - 1 ||
        context.read<MosaicoSlideshowCubit>().state.items.length == 1) {
      return const SizedBox();
    }

    return Positioned(
      left: 0,
      bottom: 0,
      child: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: () {},
          icon: const Icon(Icons.arrow_downward),
          color: Theme.of(context).colorScheme.secondary),
    );
  }
}
