import 'package:flutter/material.dart';
import 'package:magicsquare/configuration/carousel_menu_items.dart';
import 'package:magicsquare/configuration/routes.dart';
import 'package:magicsquare/services/ble/runner_service.dart';
import 'package:magicsquare/widgets/dash_button.dart';
import 'package:magicsquare/widgets/device_status_notch.dart';
import 'configuration/app_color_scheme.dart';
import 'networking/ble_connection_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.getRoutes(),
      theme: ThemeData(
        fontFamily: 'Dotted',
        colorScheme: AppColorScheme.getDefaultColorScheme(),
      ),
      home: Builder(
        builder: (context) => const HomePage(), //TextsPage()//
      ),
    );
  }
}

class HomePage extends StatelessWidget
{
  // Home configuration
  static const double widgetSpacing = 40.0;
  static const double horizontalPadding = 10.0;

  const HomePage({super.key});

  void onPressed() async {
     RunnerService.test();
    // await BLEConnectionManager.searchAndConnectMatrix();
    // print("Once here we are connected to the matrix or the matrix is not available.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            // Header notch with device status
            const DeviceStatusNotch(),

            // Spacer
            const Spacer(),

            ElevatedButton(onPressed: onPressed, child: const Text("Clicca qui")),

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
                        child: DashButton(
                            title: "Widgets",
                            startColor: Colors.red,
                            menuItems: CarouselMenuItems.widgetsMenuItems,
                            endColor: Colors.blue),
                      ),
                      SizedBox(width: horizontalPadding),
                      Expanded(
                        child: DashButton(
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
                          child: DashButton(
                              title: "Slideshows",
                              startColor: Colors.purple,
                              endColor: Colors.orange)),
                    ],
                  ),
                  SizedBox(height: widgetSpacing),
                  Row(
                    children: [
                      Expanded(
                          child: DashButton(
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