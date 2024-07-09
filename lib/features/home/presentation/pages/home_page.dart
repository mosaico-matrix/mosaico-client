import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/widgets/home_tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              minHeight: HomePageState.notchHeight,
              parallaxEnabled: true,
              parallaxOffset:1,
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
                  bottom: HomePageState.tabBarHeight + (Platform.isIOS ? 35 : 0),
                ),
                  child: state.getActivePage().page
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/store');
              },
              child: const Icon(Icons.shopping_bag),
            ),
            bottomNavigationBar: const HomeTabBar(),
          );
        },
      ),
    );
  }
}
