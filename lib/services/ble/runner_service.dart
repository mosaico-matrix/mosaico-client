import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:magicsquare/networking/ble_connection_manager.dart';
import 'package:magicsquare/services/ble/base_service.dart';

class RunnerService extends BaseService
{
  // Characteristic UUIDs
  static Guid ACTIVE_RUNNER = Guid("9d0e35da-bc0f-473e-a32c-25d33eaae17a"); // for now is TEST characteristic

  /// Get the service required by this class
  static BluetoothService runnerBluetoothService()
  {
    return BaseService.getService(Guid("d34fdcd0-83dd-4abe-9c16-1230e89ad2f2"));
  }


  /***************
   * Actual characteristic APIs *
   ***************/
  static Future<dynamic> test() async {
    return runnerBluetoothService().getCharacteristic(ACTIVE_RUNNER).write("TEST".codeUnits);
  }

  static Future<dynamic> setRunner(int runner) async {
    //return BaseService.getCharacteristic(SERVICE_UUID, ACTIVE_RUNNER).write(runner.toString().codeUnits);
  }

  // static Future<dynamic> startRunner() async {
  //   return await postData('runner/start', {});
  // }
}