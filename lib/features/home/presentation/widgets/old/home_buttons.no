import 'package:flutter/material.dart';
import 'package:mosaico/core/configuration/constants.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/led_matrix.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';

import '../../../../../core/configuration/routes.dart';
import 'home_button.dart';

class HomeButtons extends StatelessWidget {
  static const double widgetSpacing = 10.0;

  const HomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - Constants.notchHeight,
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - Constants.notchHeight,
          child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeButton(
                title: "Widgets",
                startColor: Colors.red,
                route: Routes.widgets,
                endColor: Colors.blue),
            HomeButton(
                title: "Games",
                route: '',
                startColor: Colors.green,
                endColor: Colors.yellow),
            HomeButton(
                title: "Slideshows",
                route: '',
                startColor: Colors.purple,
                endColor: Colors.orange),
            HomeButton(
                title: "Store",
                route: Routes.store,
                startColor: Colors.blue,
                endColor: Colors.red),
          ],
                ),
        ),
      ),
    );
  }
}
