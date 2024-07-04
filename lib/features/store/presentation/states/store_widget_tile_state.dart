import 'package:flutter/foundation.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_repository_impl.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widgets_repository.dart';

class StoreWidgetTileState with ChangeNotifier {
  
  final MosaicoWidgetsRepository _mosaicoWidgetsRepository = MosaicoWidgetsRepositoryImpl();
  
  bool _isInstalling = false;
  bool get isInstalling => _isInstalling;

  void installWidget(MosaicoWidget widget) async {
    _isInstalling = true;
    notifyListeners();

    try {
      await _mosaicoWidgetsRepository.installWidget(storeId: widget.storeId!);
      widget.installed = true;
    } catch (e) {
      _isInstalling = false;
      notifyListeners();
      rethrow;
    }

    _isInstalling = false;
    notifyListeners();
  }


}
