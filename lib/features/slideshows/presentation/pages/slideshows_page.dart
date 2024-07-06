import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshows_state.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_tile.dart';
import 'package:provider/provider.dart';
import '../../../../core/configuration/routes.dart';
import '../../../../shared/widgets/loadable_page.dart';

class SlideshowsPage extends StatelessWidget {

  const SlideshowsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final SlideshowsState slideshowsState = SlideshowsState();

    return LoadablePage<SlideshowsState>(
      fab: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.slideshow);
        },
        child: Icon(Icons.add),
      ),
      state: slideshowsState,
      child: Consumer<SlideshowsState>(
        builder: (context, slideshowsState, _) {
          return ListView.builder(
            itemCount: slideshowsState.slideshows.length,
            itemBuilder: (context, index) {
              return SlideshowTile();
            },
          );
        },
      ),
    );
  }
}