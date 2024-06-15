import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mosaico/configuration/carousel_menu_items.dart';
import 'package:mosaico/configuration/routes.dart';
import 'package:mosaico/exceptions/exception_handler.dart';
import 'package:mosaico/widgets/dash_button.dart';
import 'package:mosaico/widgets/device_status_notch.dart';
import 'package:mosaico/widgets/dialogs/toaster.dart';
import 'package:mosaico_flutter_core/configuration/app_color_scheme.dart';

void main() {
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    handleException(error, stackTrace);
  });
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

class HomePage extends StatelessWidget {
  // Home configuration
  static const double widgetSpacing = 40.0;
  static const double horizontalPadding = 10.0;

  const HomePage({super.key});

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
