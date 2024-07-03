import 'package:flutter/widgets.dart';

import '../../features/debug/presentation/pages/debug.dart';
import '../../features/store/presentation/pages/store_page.dart';
import '../../features/widgets/presentation/pages/installed_widgets_page.dart';

class Routes {

  static const String debug = '/debug';
  static const String store = '/store';
  static const String widgets = '/widgets';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      debug: (context) => const DebugPage(),
      store: (context) => StorePage(),
      widgets: (context) => InstalledWidgetsPage(),
    };
  }


}