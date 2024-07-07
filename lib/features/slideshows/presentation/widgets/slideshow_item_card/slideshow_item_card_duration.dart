import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshow_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:provider/provider.dart';

class SlideshowItemCardDuration extends StatelessWidget {
  final MosaicoSlideshowItem slideshowItem;
  final TextEditingController _controller = TextEditingController();
  SlideshowItemCardDuration({super.key, required this.slideshowItem});

  @override
  Widget build(BuildContext context) {

    _controller.text = slideshowItem.secondsDuration.toString();

    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _controller,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              filled: true,
              hintText: 'Seconds',
            ),
            onChanged: (value) {
              try {
                Provider.of<SlideshowState>(context, listen: false)
                    .updateItemDuration(slideshowItem, value);
              } catch (e) {}
            },
          ),
        ),
      ],
    );
  }
}
