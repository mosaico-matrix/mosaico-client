import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/pages/home.dart';
import 'package:mosaico_flutter_core/core/configuration/app_color_scheme.dart';
import 'package:mosaico_flutter_core/core/exceptions/exception_handler.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:toastification/toastification.dart';
import 'core/configuration/routes.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_wrapper.dart';

void main() {
  var loadingState = MosaicoLoadingState();
  runZonedGuarded(() {
    runApp(MosaicoLoadingWrapper(
        state: loadingState, child: const ToastificationWrapper(child: App())));
  }, (error, stackTrace) {
    handleException(error, stackTrace, loadingState);
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
        builder: (context) =>
            const Home(), //TextsPage()//
      ),
    );
  }
}
