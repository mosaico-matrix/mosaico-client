import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshow_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:provider/provider.dart';


class SlideshowItemCardConfigSelect extends StatelessWidget {

  final MosaicoSlideshowItem slideshowItem;
  const SlideshowItemCardConfigSelect({super.key, required this.slideshowItem});

  @override
  Widget build(BuildContext context) {
    // Return null when dragging
    try {
      // Wait for the configurations to be loaded before building the dropdown
      return FutureBuilder<List<MosaicoWidgetConfiguration>>(
        future: Provider.of<SlideshowState>(context).getWidgetConfigurations(
            slideshowItem.widgetId),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildConfigSelect(snapshot.data!, context);
          } else {
            return Container();
          }
        },
      );
    }
    catch (e) {
      return Container();
    }
  }

  Widget _buildConfigSelect(List<MosaicoWidgetConfiguration> configurations, BuildContext context) {
    return CustomDropdown<MosaicoWidgetConfiguration>.search(
      hintText: 'Configuration',
      items: configurations,
      excludeSelected: false,
      onChanged: (configuration) {
        var slideshowState = Provider.of<SlideshowState>(context, listen: false);
        slideshowState.updateItemConfig(slideshowItem, configuration);
      },
      initialItem: configurations.where((element) => element.id == slideshowItem.configId).firstOrNull,
      listItemBuilder: (context, configuration, _, __) =>
          Text(configuration.name),
      headerBuilder: (context, configuration, _) =>
          Text(configuration.name),
    );
  }
}
