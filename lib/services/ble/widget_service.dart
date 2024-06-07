import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:magicsquare/services/ble/base_service.dart';

class WidgetService extends BaseService
{
  // Characteristic UUIDs
  static Guid ACTIVE_WIDGET = Guid("9d0e35da-bc0f-473e-a32c-25d33eaae17a");
  static Guid INSTALLED_WIDGET = Guid("9d0e35da-bc0f-473e-a32c-25d33eaae17b");

  /// Get the service required by this class
  static BluetoothService widgetBluetoothService()
  {
    return BaseService.getService(Guid("d34fdcd0-83dd-4abe-9c16-1230e89ad2f2"));
  }



  // Install widget with provided ID
  static Future<dynamic> installWidget(int id) async {
    return await widgetBluetoothService().getCharacteristic(INSTALLED_WIDGET).write([id]);
  }

  // Get list of ids of installed widgets
  static Future<List<int>> getInstalledWidgets() async {
    List<int> installedWidgets = [];
    List<int> data = await widgetBluetoothService().getCharacteristic(INSTALLED_WIDGET).read();
    for (int i = 0; i < data.length; i++) {
      installedWidgets.add(data[i]);
    }
    return installedWidgets;
  }

  // static Future<dynamic> startRunner() async {
  //   return await postData('runner/start', {});
  // }
}