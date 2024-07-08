import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:provider/provider.dart';

class MosaicoInstalledWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;

  const MosaicoInstalledWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    final installedWidgetsState =
        Provider.of<InstalledWidgetsState>(context, listen: false);

    return Container(
      child: MosaicoWidgetTile(
        widget: widget,
        trailing: PopupMenuButton(itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: ListTile(
                  title: const Text('Edit configurations'),
                  leading: const Icon(Icons.construction),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await installedWidgetsState.showWidgetConfigurationsEditor(
                        context, widget);

                  }),
            ),
            PopupMenuItem(
                child: ListTile(
                    title: const Text('Preview'),
                    leading: const Icon(Icons.play_arrow),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await installedWidgetsState.previewWidget(context, widget);
                    })),
            PopupMenuItem(
                child: ListTile(
                    title: const Text('Delete'),
                    leading: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await installedWidgetsState.uninstallWidget(context, widget);
                    }))
          ];
        }),
      ),
    );
  }
}
