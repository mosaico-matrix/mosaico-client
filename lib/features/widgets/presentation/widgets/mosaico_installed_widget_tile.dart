import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mosaico/features/store/presentation/states/store_widget_tile_state.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_indicator_small.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/presentation/widgets/widget_configuration_editor.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/presentation/widgets/widget_configuration_picker.dart';
import 'package:provider/provider.dart';

class MosaicoInstalledWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;
  late InstalledWidgetsState installedWidgetsState;

  MosaicoInstalledWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    installedWidgetsState = Provider.of<InstalledWidgetsState>(context);
    return MosaicoWidgetTile(
        widget: widget,
        slidableActions: [
          // Show configurations
          SlidableAction(
            onPressed: showWidgetConfigurations,
            backgroundColor: const Color(0xFF4A90E2),
            foregroundColor: Colors.white,
            icon: Icons.construction,
          ),

          // Delete widget
          SlidableAction(
            onPressed: (BuildContext context) =>
                installedWidgetsState.deleteWidget(widget),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],

        // Play button
        trailing: IconButton(
            onPressed: () => playWidget(context),
            icon: const Icon(Icons.play_arrow_outlined)));
  }

  Future<void> playWidget(BuildContext context) async {
    // Get all configurations for the widget
    var configurations =
        await installedWidgetsState.getWidgetConfigurations(widget);

    // No configs, preview the widget
    if (configurations.isEmpty) {
      installedWidgetsState.previewWidget(widget);
      return;
    }

    // If there are configurations, show a dialog to select one
    final selectedConfiguration = await showDialog<MosaicoWidgetConfiguration?>(
      context: context,
      builder: (BuildContext context) {
        return WidgetConfigurationPicker(configurations: configurations);
      },
    );

    // If a configuration was selected, preview the widget
    if (selectedConfiguration != null) {
      installedWidgetsState.previewWidget(widget,
          configuration: selectedConfiguration);
    }
  }

  void showWidgetConfigurations(BuildContext context) async {
    var configurations =
        await installedWidgetsState.getWidgetConfigurations(widget);

    await showDialog<MosaicoWidgetConfiguration?>(
      context: context,
      builder: (BuildContext context) {
        return WidgetConfigurationEditor(
            configurations: configurations, widget: widget);
      },
    );
  }
}
