import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshow_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:provider/provider.dart';

class SlideshowItemCardDuration extends StatelessWidget {
  final MosaicoSlideshowItem slideshowItem;

  const SlideshowItemCardDuration({super.key, required this.slideshowItem});

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
      Expanded(
        child: TextField(
          controller: TextEditingController(text: slideshowItem.secondsDuration.toString()),
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'Seconds',
          ),
          onChanged: (value) {
            try
            {
              Provider.of<SlideshowState>(context, listen: false).updateItemDuration(slideshowItem, value);
            }
            catch(e){}
          },
        ),
      ),
      // SizedBox(width: 10),
      // Expanded(
      //   child: CustomDropdown<String>(
      //     hintText: 'Select job role',
      //     items: ['seconds', 'minutes', 'hours'],
      //     initialItem: 'seconds',
      //     onChanged: (value) {
      //     },
      //   ),
      // ),
    ],
          );

  }
}
