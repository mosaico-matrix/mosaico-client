import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_item_cubit.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:provider/provider.dart';

class SlideshowEditorItemCardDuration extends StatelessWidget {
  final Function(int) onDurationChanged;
  final int? initialDuration;
  const SlideshowEditorItemCardDuration({super.key, required this.onDurationChanged, this.initialDuration});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(

              controller: TextEditingController(text: initialDuration?.toString()),
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                filled: true,
                hintText: 'Seconds',
              ),
              onChanged: (value) => value != '' ? onDurationChanged(int.parse(value)) : null,
            ),
          ),
        ],
      ),
    );
  }
}
