import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mosaico/features/home/presentation/widgets/home_tab_bar.dart';
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
                bottomLeft: Radius.circular(HomePageState.edgeRadius),
                bottomRight: Radius.circular(HomePageState.edgeRadius),
              ),
              panel: const Center(
                child: DeviceStatusNotch(),
              ),
              body: Container(
                  margin: EdgeInsets.only(top: Constants.notchHeight - 40),
                  child: state.getActivePage().page),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
