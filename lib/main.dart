import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/debug/presentation/pages/debug.dart';
import 'package:mosaico/features/home/presentation/pages/home_tab_page.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_bloc.dart';
import 'package:mosaico/features/store/bloc/mosaico_store_bloc.dart';
import 'package:mosaico/features/widgets/bloc/mosaico_installed_widgets_bloc.dart';
import 'package:mosaico_flutter_core/core/configuration/app_color_scheme.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_event.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_wrapper.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_rest_repository.dart';
import 'package:showcaseview/showcaseview.dart';

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
        RepositoryProvider<MosaicoSlideshowsCoapRepository>(
          create: (context) => MosaicoSlideshowsCoapRepository(),
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
                      configurationsRepository: context.read(),
                    )..add(ConnectToMatrixEvent())),
            BlocProvider(
                create: (context) => MosaicoStoreBloc(
                    widgetsRestRepository: context.read(),
                    widgetsCoapRepository: context.read())),
            BlocProvider(
                create: (context) =>
                    MosaicoSlideshowsBloc(repository: context.read())),
          ],
          child: ShowCaseWidget(
            builder: (context) => MosaicoLoadingWrapper(child: const App()),
          )),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MatrixDeviceBloc, MatrixDeviceState>(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          fontFamily: 'Dotted',
          colorScheme: AppColorScheme.getDefaultColorScheme(),
        ),
        home: Builder(
          builder: (context) => HomeTabPage(),
        ),
      ),
      listener: (context, state) {
        if (state is MatrixDeviceConnectedState) {
          if (_isPingScheduled) return;

          _isPingScheduled = true;
          Future.delayed(const Duration(seconds: 8), () {
            context
                .read<MatrixDeviceBloc>()
                .add(PingMatrixAndRefreshActiveWidgetEvent(state));
            _isPingScheduled = false; // Reset the flag after ping is done
          });
        }
      },
    );
  }
}

// A variable to track if a ping is already scheduled
bool _isPingScheduled = false;
