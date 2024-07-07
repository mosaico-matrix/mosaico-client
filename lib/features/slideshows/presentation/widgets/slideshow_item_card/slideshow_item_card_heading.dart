import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_heading.dart';
import 'package:provider/provider.dart';

import '../../states/slideshow_state.dart';

class SlideshowItemCardHeading extends StatelessWidget {

  final int position;
  const SlideshowItemCardHeading({super.key, required this.position});

  @override
  Widget build(BuildContext context) {

    SlideshowState? slideshowState;
    // This is needed as when dragging this item the slideshowState is not available
    try {
      slideshowState = Provider.of<SlideshowState>(context);
    } catch (e) {}

    return MosaicoHeading(
        text: slideshowState == null
            ? 'Widget ${position + 1}'
            : 'Widget ${position + 1} of ${slideshowState.getItemsCount().toString()}'
    );
  }
}
