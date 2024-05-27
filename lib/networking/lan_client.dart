import 'package:flutter/material.dart';
import 'package:magicsquare/configuration/configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LanClient
{
  static Future<String> getMatrixIp() async {
    return Configs.debugMatrixIp;
    var preferences = await SharedPreferences.getInstance();
    return preferences.getString('matrixIp') ?? "";
  }
}