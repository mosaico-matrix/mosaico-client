import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:magicsquare/networking/ble_connection_manager.dart';
import 'package:magicsquare/services/ble/base_service.dart';

class RunnerService extends BaseService
{
  // Characteristic UUIDs
  static Guid ACTIVE_RUNNER = Guid(""); // for now is TEST characteristic

  /// Get the service required by this class
  static BluetoothService runnerBluetoothService()
  {
    return BaseService.getService(Guid(""));
  }


  /***************
   * Actual characteristic APIs *
   ***************/


  static Future<dynamic> setRunner(int runner) async {
    return runnerBluetoothService().getCharacteristic(ACTIVE_RUNNER).write("TEST".codeUnits);
  }

  // static Future<dynamic> startRunner() async {
  //   return await postData('runner/start', {});
  // }
}