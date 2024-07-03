import 'package:flutter/cupertino.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_repository_impl.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_repository_impl.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widget_configurations_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widgets_repository.dart';

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

  /// Initialize and load widgets
  @override
  Future<void> loadResource() async {
    loadingState.showLoading();
    _widgets = await _widgetsRepository.getInstalledWidgets();
    loadingState.hideLoading();
    notifyListeners();
  }

  Future<void> deleteWidget(MosaicoWidget widget) async {
    loadingState.showOverlayLoading();
    await _widgetsRepository.uninstallWidget(widgetId: widget.id);
    _widgets?.remove(widget);
    loadingState.hideOverlayLoading();
    notifyListeners();
  }

  Future<List<MosaicoWidgetConfiguration>> getWidgetConfigurations(MosaicoWidget widget) async {
    loadingState.showOverlayLoading();
    final configurations = await _configurationsRepository.getWidgetConfigurations(widgetId: widget.id);
    loadingState.hideOverlayLoading();
    return configurations;
  }

  Future<void> previewWidget(MosaicoWidget widget, {MosaicoWidgetConfiguration? configuration}) async {
    loadingState.showOverlayLoading();
    await _widgetsRepository.previewWidget(widgetId: widget.id, configurationId: configuration?.id);
    loadingState.hideOverlayLoading();
    notifyListeners();
  }
}
