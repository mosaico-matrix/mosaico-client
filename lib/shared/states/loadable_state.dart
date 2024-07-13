import 'package:flutter/cupertino.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:provider/provider.dart';

abstract class LoadableState extends ChangeNotifier {

  /// Load resource from external source
  Future<void> loadResource(BuildContext context);

  /// This can be true even if the resource is not loaded yet
  /// Child classes should implement this method to check if the resource is empty
  bool empty();

  /// Check if no data is available for the resource
  bool noData(){
    return _initialized && empty();
  }

  /// Prevent multiple initializations
  bool _initialized = false;
  Future<void> init(BuildContext context) async
  {
    // Get device state
    var deviceState = Provider.of<MosaicoDeviceState>(context, listen: false);

    // Still connecting, wait before initializing
    // TODO: this is pure shit, fix it when possible
    if(deviceState.isConnecting){
      //loadingState.showLoading();
      for(int i = 0; i < 5; i++){
        await Future.delayed(const Duration(milliseconds: 500));
        if(deviceState.isConnecting) continue;
        break;
      }
      //loadingState.hideLoading();
    }

    if (_initialized) return;
    _initialized = true;
    loadResource(context);
  }

  /// Loading state
  late MosaicoLoadingState loadingState;
  void setLoadingState(MosaicoLoadingState loadingState) {
    this.loadingState = loadingState;
  }

  /// This just triggers a UI refresh
  void render()
  {
    loadingState.showLoading();
    notifyListeners();
    loadingState.hideLoading();
  }
}