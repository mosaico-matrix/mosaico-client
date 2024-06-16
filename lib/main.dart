import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mosaico/configuration/carousel_menu_items.dart';
import 'package:mosaico/configuration/routes.dart';
import 'package:mosaico/pages/home/home.dart';
import 'package:mosaico/pages/home/widgets/dashboard_button.dart';
import 'package:mosaico/pages/home/widgets/device_status_notch.dart';
import 'package:mosaico_flutter_core/exceptions/exception_handler.dart';
import 'package:mosaico_flutter_core/toaster.dart';
import 'package:mosaico_flutter_core/configuration/app_color_scheme.dart';
import 'package:toastification/toastification.dart';

void main() {
  runZonedGuarded(() {
    runApp(const ToastificationWrapper(child: App()));
  }, (error, stackTrace) {
    handleException(error, stackTrace);
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.getRoutes(),
      theme: ThemeData(
        fontFamily: 'Dotted',
        colorScheme: AppColorScheme.getDefaultColorScheme(),
      ),
      home: Builder(
        builder: (context) =>  const Home(), //TextsPage()//
      ),
    );
  }
}
