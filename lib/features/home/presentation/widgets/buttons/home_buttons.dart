import 'package:flutter/material.dart';

import '../../../../../core/configuration/routes.dart';
import 'home_button.dart';

class HomeButtons extends StatelessWidget {
  // Home configuration
  static const double widgetSpacing = 40.0;
  static const double horizontalPadding = 10.0;
  const HomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          children: [
            Row(
              // Enlarge children to fill the space
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: HomeButton(
                      title: "Widgets",
                      startColor: Colors.red,
                      route: Routes.widgets,
                      endColor: Colors.blue),
                ),
                SizedBox(width: horizontalPadding),
                Expanded(
                  child: HomeButton(
                      title: "Games",
                      route: '',
                      startColor: Colors.green,
                      endColor: Colors.yellow),
                ),
              ],
            ),
            SizedBox(height: widgetSpacing),
            Row(
              children: [
                Expanded(
                    child: HomeButton(
                        title: "Slideshows",
                        route: '',
                        startColor: Colors.purple,
                        endColor: Colors.orange)),
              ],
            ),
            SizedBox(height: widgetSpacing),
            Row(
              children: [
                Expanded(
                    child: HomeButton(
                        title: "Store",
                        route: Routes.store,
                        startColor: Colors.blue,
                        endColor: Colors.red)),
              ],
            ),
          ],
        ),
      );
  }
}