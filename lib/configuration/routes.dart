import 'package:flutter/widgets.dart';
import '../pages/debug/debug.dart';

class Routes {

  static const String texts = '/texts';
  static const String text = '/text';
  static const String images = '/images';
  static const String boards = '/boards';
  static const String controllerTest = '/controllerTest';
  static const String debug = '/debug';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      debug: (context) => const DebugPage(),
    };
  }


}