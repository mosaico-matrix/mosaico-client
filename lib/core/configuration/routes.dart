import 'package:flutter/widgets.dart';
import 'package:mosaico/shared/pages/widget_details/mosaico_widget_details_page.dart';

import '../../features/debug/presentation/pages/debug.dart';
import '../../features/slideshows/presentation/pages/slideshow_page.dart';
import '../../features/store/presentation/pages/store_page.dart';

class Routes {

  static const String debug = '/debug';
  static const String store = '/store';
  static const String widgetDetails = '/widgets_details';
  static const String slideshow = '/slideshow';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      debug: (context) => const DebugPage(),
      store: (context) => const StorePage(),
      widgetDetails: (context) => const MosaicoWidgetDetailsPage(),
      slideshow: (context) => const SlideshowPage(),
    };
  }


}