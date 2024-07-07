import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_item_card/slideshow_item_card.dart';
import 'package:provider/provider.dart';

import '../states/slideshow_state.dart';

class SlideshowEditor extends StatelessWidget {
  const SlideshowEditor({super.key});

  @override
  Widget build(BuildContext context) {

    var slideshowState = Provider.of<SlideshowState>(context);
    var slideshowItems = slideshowState.getItems();

    for (var i = 0; i < slideshowItems.length; i++) {
      print('Item at position ${slideshowItems[i].position} has widgetId: ${slideshowItems[i].widgetId}');
    }

    return DragAndDropLists(
      onItemReorder: (oldItemIndex, oldListIndex, newItemIndex, newListIndex) {
        slideshowState.updateItemPosition(oldItemIndex, newItemIndex);
      },
      onListReorder: (int oldListIndex, int newListIndex) {},
      children: [
        DragAndDropList(
          contentsWhenEmpty: Container(),
          children: [
            for (var item in slideshowItems)
              DragAndDropItem(
                child: SlideshowItemCard(slideshowItem: item),
              ),
          ],
        ),
      ],
    );
  }
}
