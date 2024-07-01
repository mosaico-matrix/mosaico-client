import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/pages/home.dart';
import 'package:mosaico_flutter_core/core/configuration/app_color_scheme.dart';
import 'package:mosaico_flutter_core/core/exceptions/exception_handler.dart';
import 'package:toastification/toastification.dart';

import 'core/configuration/routes.dart';

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
        builder: (context) => const Home(), //TextsPage()//
      ),
    );
  }
}
