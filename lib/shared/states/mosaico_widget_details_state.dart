import 'package:flutter/material.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_rest_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widgets_repository.dart';

class MosaicoWidgetDetailsState extends LoadableState {

  /// Widget
  final int _storeId;
  MosaicoWidget? _storeWidget;
  MosaicoWidget get storeWidget => _storeWidget!;
  MosaicoWidgetDetailsState(this._storeId);

  /// Repositories
  final MosaicoWidgetsRestRepository _widgetsRepository =
      MosaicoWidgetsRestRepository();

  @override
  bool empty() {
    return _storeWidget == null;
  }

  @override
  Future<void> loadResource(BuildContext context) async {
    loadingState.showLoading();
    _storeWidget = await _widgetsRepository.getWidgetDetails(storeId: _storeId);
    loadingState.hideLoading();
  }
}
