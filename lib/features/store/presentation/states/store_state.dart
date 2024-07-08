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
  final MosaicoWidgetsRepository _widgetsRepository = MosaicoWidgetsRestRepository();
  final MosaicoLocalWidgetsRepository _localWidgetsRepository = MosaicoWidgetsCoapRepository();

  /// List of widgets
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

    // Fetch widgets and installed widgets
    final storeWidgets = await _widgetsRepository.getStoreWidgets();
    final installedWidgets = await _localWidgetsRepository.getInstalledWidgets();

    // Set installed status
    _widgets = storeWidgets.map((widget) {
      widget.installed = installedWidgets
          .any((installed) => installed.storeId == widget.storeId);
      return widget;
    }).toList();

    loadingState.hideLoading();
    notifyListeners();
  }

  /// Install a widget
  int? _installingId;
  bool isInstalling(int storeId) => _installingId == storeId;

  void installWidget(MosaicoWidget widget) async {
    _installingId = widget.storeId!;
    notifyListeners();

    try {
      await _localWidgetsRepository.installWidget(storeId: widget.storeId!);
      widget.installed = true;
    } catch (e) {
      _installingId = null;
      notifyListeners();
      rethrow;
    }

    _installingId = null;
    notifyListeners();

    // Refresh also installed widgets
    installedWidgetsState.refresh();
  }
}
