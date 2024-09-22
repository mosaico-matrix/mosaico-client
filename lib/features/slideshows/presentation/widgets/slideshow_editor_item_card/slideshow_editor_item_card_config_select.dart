import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';

class SlideshowEditorItemCardConfigSelect extends StatelessWidget {


  final List<MosaicoWidgetConfiguration>? configurations;
  final int? initialConfigId;
  final Function(MosaicoWidgetConfiguration?) setConfig;

  const SlideshowEditorItemCardConfigSelect(
      {super.key, required this.setConfig, required this.configurations, required this.initialConfigId});

  @override
  Widget build(BuildContext context) {
    if (configurations == null) return const SizedBox();

    try {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: CustomDropdown<MosaicoWidgetConfiguration>.search(
          hintText: 'Configuration',
          noResultFoundBuilder: (context, search) =>
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              textAlign: TextAlign.center,
              'No configurations found, please add a configuration for this widget before selecting it',
            ),
          ),
          items: configurations,
          excludeSelected: false,
          onChanged: (configuration) {
            if (configuration == null) return;
            setConfig(configuration);
          },
          initialItem: (initialConfigId != null && configurations != null)
              ? configurations!.firstWhere((element) =>
          element.id == initialConfigId)
              : null,
          listItemBuilder: (context, configuration, _, __) =>
              Text(configuration.name),
          headerBuilder: (context, configuration, _) =>
              Text(configuration.name),
        ),
      );
    }
    catch (e) {

      setConfig(null);

      return const Text(
        'The configuration that was previously selected is not currently available.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      );
    }
  }
}
