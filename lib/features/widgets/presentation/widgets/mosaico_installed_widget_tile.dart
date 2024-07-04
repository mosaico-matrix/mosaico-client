import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:provider/provider.dart';

class MosaicoInstalledWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;

  MosaicoInstalledWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    final installedWidgetsState = Provider.of<InstalledWidgetsState>(context, listen: false);

    return MosaicoWidgetTile(
        widget: widget,
        slidableActions: [
          Visibility(
            visible: widget.metadata!.configurable,
            child: SlidableAction(
              onPressed: (context) => installedWidgetsState.showWidgetConfigurationsEditor(context, widget),
              backgroundColor: const Color(0xFF4A90E2),
              foregroundColor: Colors.white,
              icon: Icons.construction,
            ),
          ),
          SlidableAction(
            onPressed: (context) => installedWidgetsState.uninstallWidget(context, widget),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
        trailing: IconButton(
            onPressed: () => installedWidgetsState.previewWidget(context, widget),
            icon: const Icon(Icons.play_arrow_outlined)));
  }
}
