import 'package:flutter/widgets.dart';
import 'package:magicsquare/pages/widgets/boards_page.dart';

import '../pages/controller_test_page.dart';
import '../pages/widgets/text_page.dart';
import '../pages/widgets/texts_page.dart';

class Routes {

  static const String texts = '/texts';
  static const String text = '/text';
  static const String images = '/images';
  static const String boards = '/boards';
  static const String controllerTest = '/controllerTest';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      texts: (context) => TextsPage(),
      text: (context) => TextPage(),
      images: (context) => TextsPage(),
      boards: (context) => BoardsPage(),
      controllerTest: (context) => ControllerTestPage(),
    };
  }


}