import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshows_state.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico/shared/widgets/mosaico_tile.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_heading.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:provider/provider.dart';

import '../../../../core/configuration/routes.dart';

class SlideshowTile extends StatelessWidget {
  final MosaicoSlideshow slideshow;

  const SlideshowTile({super.key, required this.slideshow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      Navigator.pushNamed(context, Routes.slideshow, arguments: slideshow);
    }, child: Consumer<SlideshowsState>(
        builder: (context, slideshowsState, _) {
      return Consumer<InstalledWidgetsState>(
        builder: (context, installedWidgetsState, _) {
          return MosaicoTile(
              child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MosaicoHeading(text: slideshow.name),
                      PopupMenuButton(itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              child: ListTile(
                                  title: const Text('Play'),
                                  leading: const Icon(Icons.play_arrow),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    await slideshowsState.playSlideshow(
                                        context, slideshow);
                                  })),
                          PopupMenuItem(
                              child: ListTile(
                                  title: const Text('Delete'),
                                  leading: Icon(Icons.delete,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    await slideshowsState.deleteSlideshow(context, slideshow);
                                  })),
                        ];
                      }),
                    ],
                  ),
                  subtitle: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shrinkWrap: true,
                    itemCount: slideshow.items.length,
                    itemBuilder: (context, index) {
                      var widget = installedWidgetsState
                          .getWidgetById(slideshow.items[index].widgetId);
                      var widgetDuration =
                          slideshow.items[index].secondsDuration;
                      return widget != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.widgets),
                                    const SizedBox(width: 5),
                                    Text(widget.name),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(widgetDuration.toString() + "s"),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.timer),
                                  ],
                                ),
                              ],
                            )
                          : Container();
                    },
                  )));
        },
      );
    }));
  }
}
