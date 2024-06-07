import 'dart:async';
import 'dart:convert';
import 'package:tcp_client_dart/tcp_client_dart.dart';
import '../configuration/runners.dart';
import 'lan_client.dart';

class TCPClient extends LanClient {

  String? _lastMessage;
  static const int _matrixTcpPort = 8080;
  static const String _okResponse = "OK";

  // /// Get the device status
  // /// Returns a [DeviceStatus] object.
  // /// If the device is not reachable, returns null
  // static Future<DeviceStatus> getDeviceStatus() async {
  //   var res = await _sendMatrixCommand("status", {});
  //   return res != null ? DeviceStatus.fromJson(jsonDecode(res)) :
  //   new DeviceStatus(status: DeviceStatusEnum.ERROR, displayMessage: "Non è stato possibile raggiungere il dispositivo");
  // }

  /// Request the device to start a game
  /// Returns true if the game was started, false otherwise
  static Future<bool> startGame(MatrixGameEnum game) async {
    var res = await _sendMatrixCommand("start_game", {
      "game_id": MatrixRunnerValue.getMatrixGameEnumValue(game),
    });
    return res == _okResponse;
  }

  /// Request the device to stop the game
  /// Returns true if the game was stopped, false otherwise
  static Future<bool> stopGame() async {
    var res = await _sendMatrixCommand("stop_game", {});
    return res == _okResponse;
  }

  /// Request the device to display a widget
  static Future<bool> displayWidget(MatrixWidgetEnum widget, int widgetId) async {
    var res = await _sendMatrixCommand("display_widget", {
      "widget_id": widgetId,
      "widget_type": MatrixRunnerValue.getMatrixWidgetEnumValue(widget),
    });
    return res == _okResponse;
  }

  // Send data to the server
  static void findMatrix() {
    // Send data to the server
  }

  /// Generic function to send a command to the matrix with parameters
  static Future _sendMatrixCommand(String command, Map<String, dynamic> params) async {
    var message = jsonEncode({
      "command": command,
      "params": params,
    });
    var res = await _sendMessageAndClose(message);
    return res;
  }

  /// Generic function to send a message to the matrix
  static Future<String?> _sendMessageAndClose(String message) async {
    TcpClient.debug = false;
    try {
      var client =
      await TcpClient.connect(await LanClient.getMatrixIp(), _matrixTcpPort, terminatorString: '\n', timeout: const Duration(seconds: 5));
//     // this will watch the connection status
//     client.connectionStream.listen(print);
//
// // this will transform all received data into strings
//     client.stringStream.listen(print);
      print("Sending message: $message");
      var res = await client.sendAndWait(message);
      var response = res?.body;
      print("Received response: $response");
      client.flush();
      client.close();
      return response;
    } catch (e) {
      return null;
    }
  }
}