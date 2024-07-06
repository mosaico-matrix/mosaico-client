import 'package:flutter/cupertino.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';

abstract class LoadableState extends ChangeNotifier {

  /// Load resource from external source
  Future<void> loadResource();

  /// This can be true even if the resource is not loaded yet
  /// Child classes should implement this method to check if the resource is empty
  bool empty();

  /// Check if no data is available for the resource
  bool noData(){
    return _initialized && empty();
  }

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