import 'dart:io';

import 'package:udp/udp.dart';

import 'lan_client.dart';

class UdpClient extends LanClient {
  static UDP? _client;

  static void sendChar(String char) async {
    var result = await _client!.send(char.codeUnits, Endpoint.multicast(InternetAddress(await LanClient.getMatrixIp()), port: Port(9182)));
  }

  static Future initializeClientAsync() async {
    _client = await UDP.bind(Endpoint.any());
  }

  static void dispose() {
    _client!.close();
  }
}
