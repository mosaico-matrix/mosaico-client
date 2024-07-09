import 'package:flutter/material.dart';
import 'package:mosaico/features/widgets/presentation/widgets/mosaico_configuration_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';

class WidgetConfigurationPicker extends StatelessWidget {
  final List<MosaicoWidgetConfiguration> configurations;

  const WidgetConfigurationPicker({super.key, required this.configurations});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a configuration'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
      content: Column(
        children: configurations.map((configuration) {
          return GestureDetector(
              onTap: () => Navigator.pop(context, configuration),
              child: MosaicoConfigurationTile(configuration: configuration));
        }).toList(),
      ),
    );
  }
}
