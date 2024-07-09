import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:mosaico_flutter_core/features/config_generator/data/models/config_output.dart';
import 'package:mosaico_flutter_core/features/config_generator/presentation/pages/config_form_page.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_local_widgets_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widget_configurations_repository.dart';

class WidgetConfigurationEditorState extends ChangeNotifier {
  final MosaicoLoadingState loadingState;

  WidgetConfigurationEditorState(this.loadingState);

  /// Repositories
  final MosaicoLocalWidgetsRepository _widgetsRepository =
      MosaicoWidgetsCoapRepository();
  final MosaicoWidgetConfigurationsRepository _configurationsRepository =
      MosaicoWidgetConfigurationsCoapRepository();

  /// List of configurations
  List<MosaicoWidgetConfiguration>? _configurations;

  List<MosaicoWidgetConfiguration> get configurations => _configurations ?? [];

  /// Load configurations from the matrix
  Future<void> loadConfigurations(MosaicoWidget widget) async {
    // Check if already loaded
    if (_configurations != null) {
      return;
    }
    _configurations = [];

    loadingState.showOverlayLoading();
    _configurations = await _configurationsRepository.getWidgetConfigurations(
        widgetId: widget.id);
    loadingState.hideOverlayLoading();
  }

  /// Add a new configuration to the widget
  Future<void> addNewConfiguration(
      BuildContext context, MosaicoWidget widget) async {

    // Get configuration form
    loadingState.showOverlayLoading();
    var configForm = await _widgetsRepository.getWidgetConfigurationForm(
        widgetId: widget.id);
    loadingState.hideOverlayLoading();

    // Make user fill the configuration form
    ConfigOutput? generatedConfig = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfigFormPage(configForm),
      ),
    );

    // User dismissed the configuration form
    if (generatedConfig == null) {
      return;
    }

    // Upload the configuration to the matrix
    loadingState.showOverlayLoading();
    var newConfig = await _configurationsRepository.uploadWidgetConfiguration(
        widgetId: widget.id,
        configurationName: generatedConfig.getConfigName(),
        configurationArchivePath: generatedConfig.exportToArchive());
    loadingState.hideOverlayLoading();

    // Add configuration to the list
    _configurations!.add(newConfig);

    notifyListeners();
  }

  /// Remove a configuration from the widget
  Future<void> deleteConfiguration(
      BuildContext context, MosaicoWidgetConfiguration configuration) async {

    // Show confirmation dialog
    var answer = ConfirmationDialog.ask(
        context: context,
        title: 'Delete configuration',
        message: "Are you sure you want to delete '${configuration.name}' configuration?");

    if (!await answer) {
      return;
    }

    loadingState.showOverlayLoading();
    await _configurationsRepository.deleteWidgetConfiguration(
        configurationId: configuration.id!);
    loadingState.hideOverlayLoading();

    _configurations!.remove(configuration);
    notifyListeners();
  }

  /// Downloads the previous configuration and allows the user to edit it
  Future<void> editConfiguration(BuildContext context, MosaicoWidgetConfiguration configuration, MosaicoWidget widget) async {

    loadingState.showOverlayLoading();

    // Get previous configuration package
    var oldPackagePath = await _configurationsRepository.getWidgetConfigurationPackage(configurationId: configuration.id!);

    // Get configuration form
    var configForm = await _widgetsRepository.getWidgetConfigurationForm(widgetId: widget.id);
    loadingState.hideOverlayLoading();


    // Make user fill the configuration form
    ConfigOutput? generatedConfig = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfigFormPage(configForm, oldConfigDirPath: oldPackagePath, initialConfigName: configuration.name),
      ),
    );

    // User dismissed the configuration form
    if (generatedConfig == null) {
      return;
    }

    // Upload the configuration to the matrix
    loadingState.showOverlayLoading();
    var updatedConfig = await _configurationsRepository.updateWidgetConfiguration(
        configurationId: configuration.id!,
        configurationName: generatedConfig.getConfigName(),
        configurationArchivePath: generatedConfig.exportToArchive());
    loadingState.hideOverlayLoading();

    // Update the configuration in the list
    var index = _configurations!.indexWhere((element) => element.id == configuration.id);
    _configurations![index] = updatedConfig;
    notifyListeners();
  }
}
