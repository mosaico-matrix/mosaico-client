import 'package:flutter/material.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_rest_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_local_widgets_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widgets_repository.dart';

class StoreState extends LoadableState {
  final InstalledWidgetsState installedWidgetsState;

  StoreState({required this.installedWidgetsState});

  /// Widget repository
  final MosaicoWidgetsRestRepository _widgetsRepository =
      MosaicoWidgetsRestRepository();
  final MosaicoWidgetsCoapRepository _localWidgetsRepository =
      MosaicoWidgetsCoapRepository();

  /// List of widgets
  List<MosaicoWidget>? _widgets;

  List<MosaicoWidget>? get widgets => _widgets;

  @override
  bool empty() {
    return _widgets?.isEmpty ?? true;
  }

  /// Initialize and load widgets
  @override
  Future<void> loadResource(BuildContext context) async {
    loadingState.showLoading();

    // Fetch widgets and installed widgets
    _widgets = await _widgetsRepository.getStoreWidgets();
    loadingState.hideLoading();
    notifyListeners();

    // Try to get installed widgets
    List<MosaicoWidget> installedWidgets = [];
    try {
      installedWidgets = installedWidgetsState.getInstalledWidgets();
      // Set installed status
      _widgets = _widgets?.map((widget) {
        widget.installed = installedWidgets
            .any((installed) => installed.storeId == widget.storeId);
        return widget;
      }).toList();
    } catch (e) {
      // Maybe user just wants to check store without being connected to the matrix
    }

    notifyListeners();
  }

  /// Install a widget
  int? _installingId;
  bool isInstalling(int storeId) => _installingId == storeId;
  bool isInstallingAnotherWidget(int storeId) => _installingId != null && _installingId != storeId;
  Future<void> installWidget(MosaicoWidget widget) async {
    _installingId = widget.storeId!;
    notifyListeners();

    try {
      var newWidget = await _localWidgetsRepository.installWidget(storeId: widget.storeId!);
      widget.installed = true;
      _installingId = null;
      installedWidgetsState.add(newWidget);
      notifyListeners();
    } catch (e) {
      _installingId = null;
      notifyListeners();
      rethrow;
    }
  }

}
