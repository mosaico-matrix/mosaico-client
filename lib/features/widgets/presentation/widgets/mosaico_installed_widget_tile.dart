import 'package:flutter/material.dart';
import 'package:mosaico/features/configurations/presentation/dialogs/widget_configurations_dialog.dart';
import 'package:mosaico/features/widgets/bloc/mosaico_installed_widgets_bloc.dart';
import 'package:mosaico/features/widgets/bloc/mosaico_installed_widgets_event.dart';
import 'package:mosaico_flutter_core/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_event.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:provider/provider.dart';

class MosaicoInstalledWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;

  const MosaicoInstalledWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => previewWidget(context),
        child: MosaicoWidgetTile(
          widget: widget,
          trailing: PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              if (widget.metadata!.configurable)
                PopupMenuItem(
                  enabled: widget.metadata!.configurable,
                  child: ListTile(
                      title: const Text('Configurations'),
                      leading: const Icon(Icons.construction),
                      onTap: () async {
                        if (!widget.metadata!.configurable) return;
                        Navigator.of(context).pop();
                        await showWidgetConfigurationsDialog(context);
                      }),
                ),
              PopupMenuItem(
                  child: ListTile(
                      title: const Text('Preview'),
                      leading: const Icon(Icons.play_arrow),
                      onTap: () {
                        // Hide the dialog
                        Navigator.of(context).pop();
                        previewWidget(context);
                      })),
              PopupMenuItem(
                  child: ListTile(
                title: const Text('Delete'),
                leading: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.error),
                onTap: () => deleteWidget(context),
              )),
            ];
          }),
        ),
      ),
    );
  }

  Future<void> previewWidget(BuildContext context) async {
    // Get repositories
    var widgetsRepository = context.read<MosaicoWidgetsCoapRepository>();

    // Directly preview the widget if it is not configurable
    if (!widget.metadata!.configurable) {
      context.read<MosaicoLoadingState>().showOverlayLoading();
      await widgetsRepository.previewWidget(widgetId: widget.id).then((_) {
        updateActiveWidget(context);
      }).whenComplete(() {
        context.read<MosaicoLoadingState>().hideOverlayLoading();
      });
      return;
    }

    // Widget is configurable, let user choose
    showWidgetConfigurationsDialog(context);
  }

  Future<void> deleteWidget(BuildContext context) async {

    // Hide the dialog
    Navigator.of(context).pop();

    // Ask confirmation
    var confirm = await ConfirmationDialog.ask(context: context,
        title: "Delete widget",
        message: "Are you sure you want to delete this widget?");

    // Return if not confirmed
    if (!confirm) {
      return;
    }

    // Show loading
    context.read<MosaicoLoadingState>().showOverlayLoading();

    // Delete widget
    context
        .read<MosaicoWidgetsCoapRepository>()
        .uninstallWidget(widgetId: widget.id)
        .then((value) {
      // Reload widgets
      context
          .read<MosaicoInstalledWidgetsBloc>()
          .add(LoadInstalledWidgetsEvent());
    }).catchError((error) {
      Toaster.error("Failed to delete widget: $error");
    }).whenComplete(() {
      context.read<MosaicoLoadingState>().hideOverlayLoading();
    });
  }

  Future<void> showWidgetConfigurationsDialog(BuildContext context) async {
    // Choose configuration or edit configs
    var selectedConfiguration = await showDialog<MosaicoWidgetConfiguration?>(
      context: context,
      builder: (BuildContext context) {
        return WidgetConfigurationsDialog(widget: widget);
      },
    );

    // Return if no configuration was selected
    if (selectedConfiguration == null) {
      return;
    }

    // Show loading
    var loadingState = context.read<MosaicoLoadingState>();
    loadingState.showOverlayLoading();

    // Get repositories
    var widgetsRepository = context.read<MosaicoWidgetsCoapRepository>();
    var configurationsRepository =
        context.read<MosaicoWidgetConfigurationsCoapRepository>();

    // Preview widget
    await widgetsRepository
        .previewWidget(
            widgetId: widget.id, configurationId: selectedConfiguration.id)
        .then((_) {
      updateActiveWidget(context, configuration: selectedConfiguration);
    }).whenComplete(() {
      loadingState.hideOverlayLoading();
    });
  }

  void updateActiveWidget(BuildContext context,
      {MosaicoWidgetConfiguration? configuration}) {
    // Get matrix state
    var matrixBloc = context.read<MatrixDeviceBloc>();
    var matrixState = matrixBloc.state;
    if (matrixState is! MatrixDeviceConnectedState) {
      return;
    }

    // Send update
    matrixBloc.add(UpdateMatrixDeviceStateEvent(matrixState.copyWith(
        activeWidget: widget, activeWidgetConfiguration: configuration)));
  }
}
