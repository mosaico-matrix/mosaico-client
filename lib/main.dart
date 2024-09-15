import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/home/presentation/pages/home_page.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico_flutter_core/core/configuration/app_color_scheme.dart';
import 'package:mosaico_flutter_core/core/exceptions/exception_handler.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_event.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_wrapper.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/bloc/mosaico_installed_widgets_bloc.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_rest_repository.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'core/configuration/routes.dart';

void main() async {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MosaicoWidgetsCoapRepository>(
          create: (context) => MosaicoWidgetsCoapRepository(),
        ),
        RepositoryProvider<MosaicoWidgetsRestRepository>(
          create: (context) => MosaicoWidgetsRestRepository(),
        ),
        RepositoryProvider<MosaicoWidgetConfigurationsCoapRepository>(
          create: (context) => MosaicoWidgetConfigurationsCoapRepository(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<MosaicoInstalledWidgetsBloc>(
              create: (context) => MosaicoInstalledWidgetsBloc(
                repository: context.read(),
              ),
            ),
            BlocProvider<MatrixDeviceBloc>(
                create: (context) => MatrixDeviceBloc(
                      widgetsRepository: context.read(),
                    )..add(ConnectToMatrixEvent())),
          ],
          child: ToastificationWrapper(
              child: MosaicoLoadingWrapper(child: const App()))),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
