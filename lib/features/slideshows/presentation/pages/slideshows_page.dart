import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshows_state.dart';
import 'package:provider/provider.dart';
import '../../../../core/configuration/routes.dart';
import '../../../../shared/widgets/loadable_page.dart';
import '../widgets/slideshow_tile.dart';

class SlideshowsPage extends StatelessWidget {

  const SlideshowsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return LoadablePage<SlideshowsState>(
      noDataHintText: "A slideshow is just a sequence of widgets, try to create one by clicking the button below",
      fab: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.slideshow).then(
            (value) => Provider.of<SlideshowsState>(context, listen: false).render(),
          );
        },
        child: const Icon(Icons.add),
      ),
      state: Provider.of(context, listen: false),
      child: Consumer<SlideshowsState>(
        builder: (context, slideshowsState, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: slideshowsState.slideshows.length,
            itemBuilder: (context, index) {
              return SlideshowTile(slideshow: slideshowsState.slideshows[index]);
            },
          );
        },
      ),
    );
  }
}