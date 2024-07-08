import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_item_card/slideshow_item_card_config_select.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_item_card/slideshow_item_card_duration.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_item_card/slideshow_item_card_heading.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_item_card/slideshow_item_card_widget_select.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:provider/provider.dart';

import '../../states/slideshow_state.dart';

class SlideshowItemCard extends StatelessWidget {
  static const double _spacing = 20;
  final MosaicoSlideshowItem slideshowItem;

  const SlideshowItemCard({super.key, required this.slideshowItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<InstalledWidgetsState>(
        builder: (context, installedWidgetsState, _) {
      return Stack(children: [
        _buildCard(
            Column(
              children: [
                SlideshowItemCardHeading(position: slideshowItem.position),
                const SizedBox(height: _spacing),
                SlideshowItemCardWidgetSelect(slideshowItem: slideshowItem),
                const SizedBox(height: _spacing),
                SlideshowItemCardConfigSelect(slideshowItem: slideshowItem),
                const SizedBox(height: _spacing),
                SlideshowItemCardDuration(slideshowItem: slideshowItem),
              ],
            ),
            context),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Provider.of<SlideshowState>(context, listen: false)
                    .removeSlideshowItem(slideshowItem);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error),
        ),
      ]);
    });
  }

  Widget _buildCard(Widget child, BuildContext context) {
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
}
