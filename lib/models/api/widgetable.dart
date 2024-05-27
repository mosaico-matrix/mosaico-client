import 'package:flutter/material.dart';
import 'package:magicsquare/models/api/serializable.dart';

abstract class Widgetable implements Serializable {
  late int id;

  Widget toWidget();
}