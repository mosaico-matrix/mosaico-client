import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/shared/widgets/pixel_rain.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../states/home_page_state.dart';
import '../widgets/notch/device_notch.dart';

class HomeTabPage extends StatelessWidget {
  const HomeTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: Consumer<HomePageState>(
        builder: (context, state, child) {
          return Scaffold(
            body: SlidingUpPanel(
              slideDirection: SlideDirection.DOWN,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              minHeight: HomePageState.notchHeight,
              parallaxEnabled: true,
              parallaxOffset: 0.3,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(HomePageState.edgeRadius),
                bottomRight: Radius.circular(HomePageState.edgeRadius),
              ),
              panel: const Center(
                child: DeviceStatusNotch(),
              ),
              body: Container(
                  padding: EdgeInsets.only(
                    top: HomePageState.notchHeight + 10,
                    bottom:
                        HomePageState.tabBarHeight + (Platform.isIOS ? 35 : 0),
                  ),
                  child: PixelRain(child: state.getActivePage().page)),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: // animate with scale
                state.getFab(context),
            bottomNavigationBar: _buildTabBar(state, context),
          );
        },
      ),
    );
  }

  Widget _buildTabBar(HomePageState homePageState, BuildContext context)
  {
    return AnimatedBottomNavigationBar.builder(
      height: HomePageState.tabBarHeight,
      activeIndex: homePageState.currentIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      notchMargin: 10,
      leftCornerRadius: HomePageState.edgeRadius,
      rightCornerRadius: HomePageState.edgeRadius,
      onTap: (index) => homePageState.changePage(index),
      itemCount: homePageState.pagesCount,
      tabBuilder: (int index, bool isActive) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Icon(
                homePageState.pages[index].icon,
                size: 24,
                color: isActive ? Theme.of(context).colorScheme.onSurface : Colors.grey,
              ),
              Text(
                homePageState.pages[index].title,
                style: TextStyle(
                    color: isActive ? Theme.of(context).colorScheme.onSurface : Colors.grey,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
              ),
            ],
          ),
        );
        //other params
      },
    );
  }
}
