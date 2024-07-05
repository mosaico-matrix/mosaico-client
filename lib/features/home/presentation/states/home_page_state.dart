import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/pages/store_page.dart';
import 'package:mosaico/features/widgets/presentation/pages/installed_widgets_page.dart';

class HomePageState extends ChangeNotifier
{
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  var pages = [
    InstalledWidgetsPage(),
    StorePage(),
  ];

  void changePage(int index)
  {
    _currentIndex = index;
    notifyListeners();
  }

  Widget getActivePage()
  {
    return pages[_currentIndex];
  }



}