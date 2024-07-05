import 'package:flutter/widgets.dart';
import 'package:mosaico/shared/pages/widget_details/mosaico_widget_details_page.dart';

import '../../features/debug/presentation/pages/debug.dart';
import '../../features/store/presentation/pages/store_page.dart';
import '../../features/widgets/presentation/pages/installed_widgets_page.dart';

class Routes {

  static const String debug = '/debug';
  static const String store = '/store';
  static const String widgets = '/widgets';
  static const String widgetDetails = '/widgets_details';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      debug: (context) => const DebugPage(),
      store: (context) => StorePage(),
      widgets: (context) => InstalledWidgetsPage(),
      widgetDetails: (context) => const MosaicoWidgetDetailsPage(),
    };
  }


}