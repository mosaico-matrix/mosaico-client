import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mosaico/features/widgets/presentation/widgets/dialogs/widget_configuration_editor.dart';
import 'package:mosaico/features/widgets/presentation/widgets/dialogs/widget_configuration_picker.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_event.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/bloc/mosaico_installed_widgets_bloc.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/bloc/mosaico_installed_widgets_event.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
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
                      title: const Text('Edit configurations'),
                      leading: const Icon(Icons.construction),
                      onTap: () async {
                        if (!widget.metadata!.configurable) return;
                        Navigator.of(context).pop();
                        await showWidgetConfigurationsEditor(context, widget);
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
    var configurationsRepository = context.read<MosaicoWidgetConfigurationsCoapRepository>();

    // Show loading
    var loadingState = context.read<MosaicoLoadingState>();
    loadingState.showOverlayLoading();

    // Directly preview the widget if it is not configurable
    if (!widget.metadata!.configurable) {
      await widgetsRepository.previewWidget(widgetId: widget.id);
      loadingState.hideOverlayLoading();
      return;
    }

    // Get widget configurations
    var configurations = await configurationsRepository
        .getWidgetConfigurations(widgetId: widget.id);
    if (configurations.isEmpty) {
      // No configurations, need to add
      loadingState.hideOverlayLoading();
      Toaster.warning("You need to add configurations to preview this widget");
      await showWidgetConfigurationsEditor(context, widget);
      return;
    }

    // Get selected configuration from user
    loadingState.hideOverlayLoading();
    final selectedConfiguration = await showDialog<MosaicoWidgetConfiguration?>(
      context: context,
      builder: (BuildContext context) {
        return WidgetConfigurationPicker(configurations: configurations);
      },
    );

    // Preview the widget with the selected configuration
    if (selectedConfiguration != null) {
      await widgetsRepository.previewWidget(
          widgetId: widget.id, configurationId: selectedConfiguration.id);
    }
  }

  Future<void> deleteWidget(BuildContext context) async {
    // Hide the dialog
    Navigator.of(context).pop();

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

  Future<void> showWidgetConfigurationsEditor(
      BuildContext context, MosaicoWidget widget) async {
    await showDialog<MosaicoWidgetConfiguration?>(
      context: context,
      builder: (BuildContext context) {
        return WidgetConfigurationEditor(widget: widget);
      },
    );
  }
}
