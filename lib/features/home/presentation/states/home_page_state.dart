import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/pages/store_page.dart';
import 'package:mosaico/features/widgets/presentation/pages/installed_widgets_page.dart';
import '../../data/models/tab_page.dart';

class HomePageState extends ChangeNotifier {

  static const double edgeRadius = 40;

  /*
  * Bottom Navigation Bar
   */
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  int get pagesCount => pages.length;

  /// List of pages
  List<TabPage> pages = [
    TabPage(
        page: InstalledWidgetsPage(), title: 'Widgets', icon: Icons.widgets),
    TabPage(page: Text("AAA"), title: 'Slideshows', icon: Icons.animation),
  ];

  /// Change the current page
  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Get the active page
  TabPage getActivePage() {
    return pages[_currentIndex];
  }
}
