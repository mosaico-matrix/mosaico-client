import 'dart:async';
import 'dart:convert';
import 'package:coap/coap.dart';
import 'package:flutter/material.dart';

import '../../widgets/dialogs/toaster.dart';

// Base CoAP client class
class BaseService {
  static final _client = CoapClient(
    Uri(
      scheme: 'coap',
      host: '192.168.1.250',
      port: 5683,
    ),
  );

  static Future<Map<String, dynamic>> _processResponse(CoapResponse response) async {
    final decodedResponse = json.decode(response.payloadString);
    final message = decodedResponse['message'];
    if (message != null) {
      response.isSuccess ? Toaster.success(message) : Toaster.error(message);
    }
    return decodedResponse;
  }

  static Future<Map<String, dynamic>> get(String path) async {
    final response = await _client.get(Uri(path: path));
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> post(String path, String payload, [List<Option<Object>>? options]) async {
    final response = await _client.post(Uri(path: path), payload: payload, options: options);
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> put(String path, String payload, [List<Option<Object>>? options]) async {
    final response = await _client.put(Uri(path: path), payload: payload, options: options);
    return _processResponse(response);
  }
}
