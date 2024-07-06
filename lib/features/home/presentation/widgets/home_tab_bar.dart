import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../states/home_page_state.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {

    var homePageState = Provider.of<HomePageState>(context);

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
                color: isActive ? Theme.of(context).colorScheme.onPrimary : Colors.grey,
              ),
              Text(
                homePageState.pages[index].title,
                style: TextStyle(
                    color: isActive ? Theme.of(context).colorScheme.onPrimary : Colors.grey,
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
