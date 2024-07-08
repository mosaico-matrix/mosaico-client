import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/pages/home_page.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico_flutter_core/core/configuration/app_color_scheme.dart';
import 'package:mosaico_flutter_core/core/exceptions/exception_handler.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'core/configuration/routes.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_wrapper.dart';

void main() {
  var loadingState = MosaicoLoadingState();
  runZonedGuarded(() {
    runApp(
      // Loading is needed in the whole app
      MosaicoLoadingWrapper(
        state: loadingState,
        // Also the toasts are needed in the whole app
        child: ToastificationWrapper(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => MosaicoDeviceState()),
              ChangeNotifierProvider(create: (context) => InstalledWidgetsState()),
            ],
            child: const App(),
          ),
        ),
      ),
    );
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
        builder: (context) => const HomePage(),
      ),
    );
  }
}
