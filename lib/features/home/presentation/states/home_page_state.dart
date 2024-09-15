import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/pages/slideshows_page.dart';
import 'package:mosaico/features/widgets/presentation/pages/installed_widgets_page.dart';

class HomePageState extends ChangeNotifier {

  static const double edgeRadius = 40;
  static const double notchHeight = 150;
  static double tabBarHeight = Platform.isAndroid ? 70 : 60;

  /*
  * Bottom Navigation Bar
   */
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  int get pagesCount => pages.length;

  /// List of pages
  List<TabPage> pages = [
    TabPage(
        page: const InstalledWidgetsPage(), title: 'Widgets', icon: Icons.widgets),
    TabPage(page: const SlideshowsPage(), title: 'Slideshows', icon: Icons.animation),
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

class TabPage
{
  final Widget page;
  final String title;
  final IconData icon;

  TabPage({required this.page, required this.title, required this.icon});
}
