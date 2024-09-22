import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/store/bloc/mosaico_store_bloc.dart';
import 'package:mosaico/features/store/bloc/mosaico_store_state.dart';
import 'package:mosaico/features/widgets/bloc/mosaico_installed_widgets_bloc.dart';
import 'package:mosaico/features/widgets/bloc/mosaico_installed_widgets_event.dart';
import 'package:mosaico/features/widgets/bloc/mosaico_installed_widgets_state.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
import '../widgets/mosaico_installed_widget_tile.dart';

class InstalledWidgetsPage extends StatelessWidget {
  const InstalledWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MatrixDeviceBloc, MatrixDeviceState>(
          listener: (context, state) {
            // Only refresh if connected to a new matrix
            if (state is MatrixDeviceConnectedState && state.newConnection) {
              context
                  .read<MosaicoInstalledWidgetsBloc>()
                  .add(LoadInstalledWidgetsEvent());
            }
          },
        ),
        BlocListener<MosaicoStoreBloc, MosaicoStoreState>(
          listener: (context, state) {
            // Refresh when store is loaded, we could have new widgets
            if (state is MosaicoStoreLoadedState) {
              context
                  .read<MosaicoInstalledWidgetsBloc>()
                  .add(LoadInstalledWidgetsEvent());
            }
          },
        ),
      ],
      child: BlocBuilder<MosaicoInstalledWidgetsBloc,
          MosaicoInstalledWidgetsState>(
        builder: (context, state) {
          // Loading
          if (state is MosaicoInstalledWidgetsLoading) {
            return Center(child: Center(child: LoadingMatrix()));
          }

          // Loaded
          if (state is MosaicoInstalledWidgetsLoaded) {
            if (state.installedWidgets.isEmpty) {
              return const EmptyPlaceholder(
                  hintText: "No widgets? Install some from the store!");
            }

            return ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: state.installedWidgets.length,
              itemBuilder: (context, index) {
                return MosaicoInstalledWidgetTile(
                    widget: state.installedWidgets[index]);
              },
            );
          }

          // Error
          if (state is MosaicoInstalledWidgetsError) {
            return EmptyPlaceholder(
              hintText: state.message,
              onRetry: () {
                context
                    .read<MosaicoInstalledWidgetsBloc>()
                    .add(LoadInstalledWidgetsEvent());
              },
            );
          }

          // Not connected?
          return const EmptyPlaceholder(
              hintText: "Connect to matrix to see installed widgets");
        },
      ),
    );
  }
}
