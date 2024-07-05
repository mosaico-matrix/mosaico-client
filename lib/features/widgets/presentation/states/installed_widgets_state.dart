import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_repository_impl.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_repository_impl.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widget_configurations_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widgets_repository.dart';
import '../widgets/dialogs/widget_configuration_editor.dart';
import '../widgets/dialogs/widget_configuration_picker.dart';

class InstalledWidgetsState extends LoadableState {

  /// Repositories
  final MosaicoWidgetsRepository _widgetsRepository =
      MosaicoWidgetsRepositoryImpl();
  final MosaicoWidgetConfigurationsRepository _configurationsRepository =
      MosaicoWidgetConfigurationsRepositoryImpl();

  /// List of installed widgets
  List<MosaicoWidget>? _widgets;
  List<MosaicoWidget>? get widgets => _widgets;

  @override
  bool empty() {
    return _widgets?.isEmpty ?? true;
  }

  /// Initialize and load widgets from the matrix
  @override
  Future<void> loadResource() async {
    loadingState.showLoading();
    _widgets = await _widgetsRepository.getInstalledWidgets();
    loadingState.hideLoading();
    notifyListeners();
  }

  /// Preview a widget on the matrix
  /// If the widget is configurable, the user will be prompted to select a configuration
  /// If the widget is not configurable, it will be directly previewed
  /// If the widget has no configurations, the user will be prompted to add new configurations
  Future<void> previewWidget(BuildContext context, MosaicoWidget widget) async {
    loadingState.showOverlayLoading();

    // Directly preview the widget if it is not configurable
    if (!widget.metadata!.configurable) {
      await _widgetsRepository.previewWidget(widgetId: widget.id);
      loadingState.hideOverlayLoading();
      return;
    }

    // Get widget configurations
    var configurations = await _configurationsRepository
        .getWidgetConfigurations(widgetId: widget.id);
    if (configurations.isEmpty) {
      // No configurations, need to add
      loadingState.hideOverlayLoading();
      Toaster.warning("You need to add configurations to preview this widget");
      await showWidgetConfigurationsEditor(context, widget);
      return;
    }

    // Get selected configuration from user
    loadingState.hideOverlayLoading();
    final selectedConfiguration = await showDialog<MosaicoWidgetConfiguration?>(
      context: context,
      builder: (BuildContext context) {
        return WidgetConfigurationPicker(configurations: configurations);
      },
    );

    // Preview the widget with the selected configuration
    if (selectedConfiguration != null) {
      await _widgetsRepository.previewWidget(
          widgetId: widget.id, configurationId: selectedConfiguration.id);
    }
  }

  /// Uninstall a widget and remove its files
  Future<void> uninstallWidget(BuildContext context, MosaicoWidget widget) async {

    // Show confirmation dialog
    final confirmed = await ConfirmationDialog.ask(
      context: context,
      title: "Uninstall widget",
      message: "Are you sure you want to uninstall '${widget.name}'?",
    );
    if (!confirmed) return;

    loadingState.showOverlayLoading();
    await _widgetsRepository.uninstallWidget(widgetId: widget.id);
    _widgets?.remove(widget);
    loadingState.hideOverlayLoading();
    notifyListeners();
  }

  /// Return a list of widget configurations
  Future<List<MosaicoWidgetConfiguration>> getWidgetConfigurations(
      MosaicoWidget widget) async {
    loadingState.showOverlayLoading();
    final configurations = await _configurationsRepository
        .getWidgetConfigurations(widgetId: widget.id);
    loadingState.hideOverlayLoading();
    return configurations;
  }

  /// Open a dialog to show available widget configurations and allow the user to add new configurations
  Future<void> showWidgetConfigurationsEditor(
      BuildContext context, MosaicoWidget widget) async {
    await showDialog<MosaicoWidgetConfiguration?>(
      context: context,
      builder: (BuildContext context) {
        return WidgetConfigurationEditor(widget: widget);
      },
    );
  }
}
