import 'package:flutter/cupertino.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_repository_impl.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widgets_repository.dart';

class StoreState extends ChangeNotifier {
  /// Widget repository
  final MosaicoWidgetsRepository _widgetsRepository;

  /// Loading state
  final MosaicoLoadingState _loadingState;

  StoreState(this._loadingState, [MosaicoWidgetsRepository? widgetsRepository])
      : _widgetsRepository =
            widgetsRepository ?? MosaicoWidgetsRepositoryImpl();

  /// List of widgets
  List<MosaicoWidget>? _widgets;

  List<MosaicoWidget>? get widgets => _widgets;

  /// Initialize and load widgets
  Future<void> init() async {
    if (_widgets != null) return;
    await _loadWidgetsFromStore();
  }

  /// Load widgets from the repository
  Future<void> _loadWidgetsFromStore() async {
    _loadingState.showLoading();

    // Fetch widgets and installed widgets
    final storeWidgets = await _widgetsRepository.getStoreWidgets();
    final installedWidgets = await _widgetsRepository.getInstalledWidgets();

    // Set installed status
    _widgets = storeWidgets.map((widget) {
      widget.installed = installedWidgets
          .any((installed) => installed.storeId == widget.storeId);
      return widget;
    }).toList();

    _loadingState.hideLoading();
    notifyListeners();
  }
}
