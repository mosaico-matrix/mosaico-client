import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mosaico/features/widgets/presentation/pages/installed_widgets_page.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../core/configuration/constants.dart';
import '../states/home_page_state.dart';
import '../widgets/notch/device_notch.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: Consumer<HomePageState>(
        builder: (context, state, child) {
          return Scaffold(
            body: SlidingUpPanel(
              slideDirection: SlideDirection.DOWN,
              minHeight: Constants.notchHeight,
              parallaxEnabled: true,
              parallaxOffset: 1,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              panel: const Center(
                child: DeviceStatusNotch(),
              ),
              body: Container(
                margin: EdgeInsets.only(top: Constants.notchHeight- 40),
                  child: state.getActivePage()),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            //   child: const Icon(Icons.add),
            // ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
                icons: [
                  Icons.home,
                  Icons.settings,
                ],
                activeIndex: 0,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.verySmoothEdge,
                leftCornerRadius: 32,
                rightCornerRadius: 32,
                onTap: (index) => state.changePage(index)
                //other params
                ),
          );
        },
      ),
    );
  }
}
