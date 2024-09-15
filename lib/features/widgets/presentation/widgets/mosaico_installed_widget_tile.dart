import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/bloc/mosaico_installed_widgets_bloc.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/bloc/mosaico_installed_widgets_event.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:provider/provider.dart';

class MosaicoInstalledWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;

  const MosaicoInstalledWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    // final installedWidgetsState =
    //     Provider.of<InstalledWidgetsState>(context, listen: false);

    return Container(
      child: GestureDetector(
        onTap: () async {
          // await installedWidgetsState.previewWidget(context, widget);
        },
        child: MosaicoWidgetTile(
          widget: widget,
          trailing: PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                enabled: widget.metadata!.configurable,
                child: ListTile(
                    title: const Text('Edit configurations'),
                    leading: const Icon(Icons.construction),
                    onTap: () async {
                      if (!widget.metadata!.configurable) return;
                      Navigator.of(context).pop();
                      // await installedWidgetsState.showWidgetConfigurationsEditor(
                      //     context, widget);
                    }),
              ),
              PopupMenuItem(
                  child: ListTile(
                      title: const Text('Preview'),
                      leading: const Icon(Icons.play_arrow),
                      onTap: () async {
                        Navigator.of(context).pop();
                        //  await installedWidgetsState.previewWidget(context, widget);
                      })),
              PopupMenuItem(
                  child: ListTile(
                title: const Text('Delete'),
                leading: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.error),
                onTap: () => deleteWidget(context),
              )),
            ];
          }),
        ),
      ),
    );
  }

  Future<void> deleteWidget(BuildContext context) async {

    // Hide the dialog
    Navigator.of(context).pop();

    // Show loading
    context.read<MosaicoLoadingState>().showOverlayLoading();

    // Delete widget
    context
        .read<MosaicoWidgetsCoapRepository>()
        .uninstallWidget(widgetId: widget.id)
        .then((value) {
      // Reload widgets
      context
          .read<MosaicoInstalledWidgetsBloc>()
          .add(LoadInstalledWidgetsEvent());
    }).catchError((error) {
      Toaster.error("Failed to delete widget: $error");
    }).whenComplete(() {
      context.read<MosaicoLoadingState>().hideOverlayLoading();
    });
  }
}
