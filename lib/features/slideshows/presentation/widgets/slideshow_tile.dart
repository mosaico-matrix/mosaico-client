import 'package:flutter/material.dart';
import 'package:mosaico/features/configurations/presentation/dialogs/widget_configurations_dialog.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_event.dart';
import 'package:mosaico/features/slideshows/presentation/pages/slideshow_editor_page.dart';
import 'package:mosaico/shared/widgets/mosaico_tile.dart';
import 'package:mosaico_flutter_core/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_heading.dart';
import 'package:mosaico_flutter_core/core/extensions/build_context_extensions.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:provider/provider.dart';

class SlideshowTile extends StatelessWidget {
  final MosaicoSlideshow slideshow;

  const SlideshowTile({super.key, required this.slideshow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SlideshowEditorPage(slideshow: slideshow)));
        },
        child: MosaicoTile(
          child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MosaicoHeading(text: slideshow.name),
                  _buildSlideshowActions(context),
                ],
              ),
              subtitle: _buildSlideshowItems(context)),
        ));
  }

  Widget _buildSlideshowItems(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        itemCount: slideshow.items.length,
        itemBuilder: (context, index) {
          var widget = context
              .read<MosaicoWidgetsCoapRepository>()
              .getByIdFromCache(slideshow.items[index].widgetId);
          var widgetDuration = slideshow.items[index].secondsDuration;
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
                        Text("${widgetDuration}s"),
                        const SizedBox(width: 5),
                        const Icon(Icons.timer),
                      ],
                    ),
                  ],
                )
              : const Row(children: [
                  Icon(Icons.error),
                  SizedBox(width: 5),
                  Text("This widget has been uninstalled!"),
                ]);
        });
  }

  Widget _buildSlideshowActions(BuildContext context) {
    return PopupMenuButton(itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
            child: ListTile(
                title: const Text('Play'),
                leading: const Icon(Icons.play_arrow),
                onTap: () {
                  Navigator.of(context).pop();
                  context.showLoading();
                  context
                      .read<MosaicoSlideshowsCoapRepository>()
                      .setActiveSlideshow(slideshow.id!)
                      .whenComplete(() => context.hideLoading())
                      .catchError((error) {
                    Toaster.error("Error playing slideshow");
                  });
                })),
        PopupMenuItem(
            child: ListTile(
                title: const Text('Edit'),
                leading: const Icon(Icons.edit),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SlideshowEditorPage(slideshow: slideshow)));
                })),
        PopupMenuItem(
            child: ListTile(
                title: const Text('Delete'),
                leading: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.error),
                onTap: () async {
                  Navigator.of(context).pop();

                  // Show confirmation dialog
                  final confirmed = await ConfirmationDialog.ask(
                    context: context,
                    title: "Delete slideshow",
                    message:
                        "Are you sure you want to delete slideshow '${slideshow.name}'?",
                  );
                  if (!confirmed) return;

                  context.showLoading();
                  context
                      .read<MosaicoSlideshowsCoapRepository>()
                      .deleteSlideshow(slideshow.id!)
                      .whenComplete(() => context.hideLoading())
                      .catchError((error) {
                    Toaster.error("Error deleting slideshow");
                  }).then((value) {
                    context
                        .read<MosaicoSlideshowsBloc>()
                        .add(LoadSlideshowsEvent());
                  });
                })),
      ];
    });
  }
}
