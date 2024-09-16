import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_item_cubit.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:provider/provider.dart';

class SlideshowEditorItemCardConfigSelect extends StatelessWidget {
  const SlideshowEditorItemCardConfigSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MosaicoSlideshowItemCubit, MosaicoSlideshowItem>(
        builder: (context, state) {
      // No slideshow selected
      if (state.widgetId == -1) {
        return const SizedBox();
      }

      return FutureBuilder(
        future: context
            .read<MosaicoWidgetConfigurationsCoapRepository>()
            .getWidgetConfigurations(widgetId: state.widgetId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                const SizedBox(height: 10.0), // Spacing at top
                _buildConfigSelect(context, snapshot.data!),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      );
    });
  }

  Widget _buildConfigSelect(
      BuildContext context, List<MosaicoWidgetConfiguration> configurations) {
    return CustomDropdown<MosaicoWidgetConfiguration>.search(
      hintText: 'Configuration',
      noResultFoundBuilder: (context, search) => const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
            textAlign: TextAlign.center,
            'No configurations found, please add a configuration for this widget before selecting it'),
      ),
      items: configurations,
      excludeSelected: false,
      onChanged: (configuration) {
        if (configuration == null) return;
        context.read<MosaicoSlideshowItemCubit>().setConfig(configuration);
      },
      initialItem: configurations
          .where((element) =>
              element.id ==
              context.read<MosaicoSlideshowItemCubit>().state.configId)
          .firstOrNull,
      listItemBuilder: (context, configuration, _, __) =>
          Text(configuration.name),
      headerBuilder: (context, configuration, _) => Text(configuration.name),
    );
  }
}
