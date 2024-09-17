
import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/config_generator/data/models/config_output.dart';
import 'package:mosaico_flutter_core/features/config_generator/presentation/pages/config_form_page.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import '../../pages/debug.dart';

class CoapSection extends StatelessWidget {

  CoapSection({super.key});

  MosaicoWidgetsCoapRepository WidgetsService = MosaicoWidgetsCoapRepository();
  MosaicoWidgetConfigurationsCoapRepository WidgetConfigurationsService = MosaicoWidgetConfigurationsCoapRepository();

  Future<MosaicoWidget> getFirstWidget() async {
    var widgets = await WidgetsService.getInstalledWidgets();
    if (widgets.isEmpty) {
      Toaster.error('No widgets found');
      throw Exception('No widgets found');
    }
    return widgets.first;
  }

  Future<void> installWidget() async {
    await WidgetsService.installWidget(storeId: 1);
  }

  Future<void> getInstalledWidgets() async {
    var widgets = await WidgetsService.getInstalledWidgets();
    if (widgets.isEmpty) {
      Toaster.error('No widgets found');
      return;
    }
    for (var widget in widgets) {
      dumpData(widget.name);
    }
  }

  Future<void> deleteFirstInstalledWidget() async {
    await WidgetsService.uninstallWidget(widgetId: (await getFirstWidget()).id);
  }

  Future<void> getWidgetConfigurationForm() async {
    var config = await WidgetsService.getWidgetConfigurationForm(widgetId: (await getFirstWidget()).id);
    dumpData(config.toString());
  }

  Future<void> createConfiguration(BuildContext context) async {
    var widgetId = (await getFirstWidget()).id;
    var configForm = await WidgetsService.getWidgetConfigurationForm(widgetId: widgetId);
    ConfigOutput? generatedConfig = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfigFormPage(configForm, initialConfigName: "TEST"),
      ),
    );

    if (generatedConfig != null) {
      await WidgetConfigurationsService.uploadWidgetConfiguration(
          widgetId: widgetId, configurationName: generatedConfig.getConfigName(), configurationArchivePath:  generatedConfig.exportToArchive());
    } else {
      Toaster.error('Configuration generation cancelled');
    }
  }

  Future<void> getWidgetConfigurations() async {
    var configs = await WidgetConfigurationsService.getWidgetConfigurations(widgetId: (await getFirstWidget()).id);
    if (configs.isEmpty) {
      Toaster.error('No configurations found');
      return;
    }
    for (var config in configs) {
      dumpData(config.name);
    }
  }

  Future<void> deleteConfiguration() async {
    var configs = await WidgetConfigurationsService.getWidgetConfigurations(widgetId: (await getFirstWidget()).id);
    for (var config in configs) {
      if (config.name == "TEST") {
        await WidgetConfigurationsService.deleteWidgetConfiguration(configurationId: config.id!);
        return;
      }
    }
    Toaster.error('Configuration named TEST not found');
  }

  Future<void> setActiveWidget() async {
    var widget = await getFirstWidget();
    var configs = await WidgetConfigurationsService.getWidgetConfigurations(widgetId: widget.id);
    for (var config in configs) {
      if (config.name == "TEST") {
        await WidgetsService.previewWidget(widgetId: widget.id, configurationId:  config.id);
        return;
      }
    }
    Toaster.error('Configuration named TEST not found');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DebugSubSection(
          title: "Install widgets",
          children: [
            ElevatedButton(
              onPressed: installWidget,
              child: const Text('Install widget with store_id 1'),
            ),
            ElevatedButton(
              onPressed: getInstalledWidgets,
              child: const Text('Get installed widgets'),
            ),
            ElevatedButton(
              onPressed: deleteFirstInstalledWidget,
              child: const Text('Delete first installed widget'),
            ),
            ElevatedButton(
              onPressed: getWidgetConfigurationForm,
              child: const Text('Get configuration form for first installed widget'),
            ),
          ],
        ),
        DebugSubSection(
          title: "Widget configurations",
          children: [
            ElevatedButton(
              onPressed: () => createConfiguration(context),
              child: const Text('Create configuration named TEST for first installed widget'),
            ),
            ElevatedButton(
              onPressed: getWidgetConfigurations,
              child: const Text('Get configurations for first installed widget'),
            ),
            ElevatedButton(
              onPressed: deleteConfiguration,
              child: const Text('Delete configuration named TEST for first installed widget')
            ),
          ],
        ),
        DebugSubSection(
          title: "Active widget",
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Get active widget'),
            ),
            ElevatedButton(
              onPressed: setActiveWidget,
              child: const Text('Set first installed widget as active with configuration named TEST')
            ),
          ],
        ),
      ],
    );
  }
}