import 'package:flutter/material.dart';
import 'package:mosaico/pages/home/widgets/dashboard_button.dart';
import 'package:mosaico/pages/home/widgets/device_status_notch.dart';

import '../../configuration/carousel_menu_items.dart';
import '../../configuration/routes.dart';


class Home extends StatelessWidget {

  // Home configuration
  static const double widgetSpacing = 40.0;
  static const double horizontalPadding = 10.0;

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            // Header notch with device status
            //const DeviceStatusNotch(),

            // Spacer
            const Spacer(),

            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.debug);
                },
                child: const Text("Debug")),

            // Main widgets
            const Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: Column(
                children: [
                  Row(
                    // Enlarge children to fill the space
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: DashboardButton(
                            title: "Widgets",
                            startColor: Colors.red,
                            menuItems: CarouselMenuItems.widgetsMenuItems,
                            endColor: Colors.blue),
                      ),
                      SizedBox(width: horizontalPadding),
                      Expanded(
                        child: DashboardButton(
                            title: "Games",
                            menuItems: CarouselMenuItems.gamesMenuItems,
                            startColor: Colors.green,
                            endColor: Colors.yellow),
                      ),
                    ],
                  ),
                  SizedBox(height: widgetSpacing),
                  Row(
                    children: [
                      Expanded(
                          child: DashboardButton(
                              title: "Slideshows",
                              startColor: Colors.purple,
                              endColor: Colors.orange)),
                    ],
                  ),
                  SizedBox(height: widgetSpacing),
                  Row(
                    children: [
                      Expanded(
                          child: DashboardButton(
                              title: "Store",
                              startColor: Colors.blue,
                              endColor: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Modal alert hidden by default
          ],
        ),
      ),
    );
  }
}

