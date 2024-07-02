import 'package:flutter/cupertino.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_repository_impl.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widgets_repository.dart';

class InstalledWidgetsState extends LoadableState {
  /// Widget repository
  final MosaicoWidgetsRepository _widgetsRepository =
      MosaicoWidgetsRepositoryImpl();

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
}
