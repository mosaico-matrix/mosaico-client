import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/presentation/pages/slideshow_editor_page.dart';
import 'package:mosaico/features/slideshows/presentation/pages/slideshows_page.dart';
import 'package:mosaico/features/store/presentation/pages/store_page.dart';
import 'package:mosaico/features/widgets/presentation/pages/installed_widgets_page.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';

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
        page: const InstalledWidgetsPage(),
        title: 'Widgets',
        icon: Icons.widgets),
    TabPage(
        page: const SlideshowsPage(),
        title: 'Slideshows',
        icon: Icons.animation),
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

  /// Get the FAB for the current page
  Widget getFab(BuildContext context) {
    switch (getActivePage().title) {
      case 'Widgets':
        return FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StorePage()),
          ),
          child: Icon(Icons.shopping_bag),
        );
      case 'Slideshows':
        return FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {

            // Check if connected to the matrix
            if(context.read<MatrixDeviceBloc>().state is! MatrixDeviceConnectedState) {
              Toaster.warning('Connect to a matrix to create a slideshow');
              return;
            }

            // Check if installed at least one widget
            context
                .read<MosaicoWidgetsCoapRepository>()
                .getInstalledWidgets()
                .then((installedWidgets) {
              if (installedWidgets.isEmpty) {
                Toaster.warning(
                    'You need to install at least one widget to create a slideshow');
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SlideshowEditorPage()),
              );
            }).catchError((error) {
              Toaster.error(
                  'Load installed widgets before creating a slideshow');
            });
          },
          child: Icon(Icons.add),
        );
    }

    throw Exception('Unknown page');
  }
}

class TabPage {
  final Widget page;
  final String title;
  final IconData icon;

  TabPage({required this.page, required this.title, required this.icon});
}
