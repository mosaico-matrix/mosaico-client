import 'package:flutter/cupertino.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';

abstract class LoadableState extends ChangeNotifier {

  /// Load resource from external source
  Future<void> loadResource();

  /// Check if the resource is empty
  bool empty();

  /// Prevent multiple initializations
  bool _initialized = false;
  void init()
  {
    if (_initialized) return;
    _initialized = true;
    loadResource();
  }

  /// Loading state
  late MosaicoLoadingState loadingState;
  void setLoadingState(MosaicoLoadingState loadingState) {
    this.loadingState = loadingState;
  }
}