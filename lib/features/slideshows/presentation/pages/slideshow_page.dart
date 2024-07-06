import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/loadable_page.dart';
import '../states/slideshow_state.dart';

class SlideshowPage extends StatelessWidget {

  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {

    return LoadablePage<SlideshowState>(
      appBar:AppBar(title:  const Text('Store')),
      state: Provider.of<SlideshowState>(context),
      child: Consumer<SlideshowState>(
        builder: (context, slideshowState, _) {
          return Text("");
        },
      ),
    );
  }
}
