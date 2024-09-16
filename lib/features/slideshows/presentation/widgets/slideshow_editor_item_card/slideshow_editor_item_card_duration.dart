import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_item_cubit.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:provider/provider.dart';

class SlideshowEditorItemCardDuration extends StatelessWidget {
  //final TextEditingController _controller = TextEditingController();
  const SlideshowEditorItemCardDuration({super.key});

  @override
  Widget build(BuildContext context) {

    //_controller.text = context.read<MosaicoSlideshowItemCubit>().state.secondsDuration.toString();

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              keyboardType: TextInputType.number,
             // controller: _controller,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                filled: true,
                hintText: 'Seconds',
              ),
              onChanged: (value) {
                context.read<MosaicoSlideshowItemCubit>().setDuration(int.parse(value));
              },
            ),
          ),
        ],
      ),
    );
  }
}
