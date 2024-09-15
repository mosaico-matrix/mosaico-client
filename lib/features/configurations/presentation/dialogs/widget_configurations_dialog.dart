import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/configurations/bloc/widget_configurations_bloc.dart';
import 'package:mosaico/features/configurations/bloc/widget_configurations_event.dart';
import 'package:mosaico/features/configurations/bloc/widget_configurations_state.dart';
import 'package:mosaico/features/configurations/presentation/widgets/mosaico_configuration_tile.dart';
import 'package:mosaico_flutter_core/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_button.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_text_button.dart';
import 'package:mosaico_flutter_core/core/extensions/build_context_extensions.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/config_generator/data/models/config_output.dart';
import 'package:mosaico_flutter_core/features/config_generator/presentation/pages/config_form_page.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:provider/provider.dart';

class WidgetConfigurationsDialog extends StatelessWidget {
  final MosaicoWidget widget;

  const WidgetConfigurationsDialog({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WidgetConfigurationsBloc(context.read())
        ..add(LoadWidgetConfigurationsEvent(widgetId: widget.id)),
      child: Builder(
        builder: (context) {
          return AlertDialog(
              title: const Text('Configurations'),
              insetPadding: EdgeInsets.zero,
              actionsOverflowAlignment: OverflowBarAlignment.center,
              actions: [
                MosaicoTextButton(
                  text: 'Close',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MosaicoButton(
                    text: 'Add new configuration',
                    onPressed: () => addNewConfiguration(context)),
              ],
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: BlocBuilder<WidgetConfigurationsBloc,
                    WidgetConfigurationsState>(builder: (context, state) {
                  // Loading
                  if (state is WidgetConfigurationsLoadingState) {
                    return LoadingMatrix();
                  }

                  // Loaded
                  if (state is WidgetConfigurationsLoadedState) {
                    return _buildConfigurationTiles(context, state.configurations);
                  }

                  // Error
                  if (state is WidgetConfigurationsErrorState) {
                    return EmptyPlaceholder(
                      hintText: "Could not load configurations",
                      onRetry: () {
                        context.read<WidgetConfigurationsBloc>().add(
                            LoadWidgetConfigurationsEvent(widgetId: widget.id));
                      },
                    );
                  }

                  return const EmptyPlaceholder();
                }),
              ));
        }
      ),
    );
  }

  Widget _buildConfigurationTiles(
      BuildContext context, List<MosaicoWidgetConfiguration> configurations) {
    if (configurations.isEmpty) return const EmptyPlaceholder();

    return Column(
      children: configurations.map((configuration) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context, configuration);
          },
          child: MosaicoConfigurationTile(
              configuration: configuration,
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: ListTile(
                      title: Text('Edit'),
                      leading: Icon(Icons.edit),
                      //  onTap: () =>  editConfiguration(context, configuration)
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                        title: const Text('Delete'),
                        leading: Icon(Icons.delete,
                            color: Theme.of(context).colorScheme.error),
                        onTap: () =>
                            deleteConfiguration(context, configuration)),
                  ),
                ],
              )),
        );
      }).toList(),
    );
  }

  Future<void> deleteConfiguration(
      BuildContext context, MosaicoWidgetConfiguration configuration) async {
    // Close the popup menu
    Navigator.of(context).pop();

    // Show confirmation dialog
    var answer = ConfirmationDialog.ask(
        context: context,
        title: 'Delete configuration',
        message:
            "Are you sure you want to delete '${configuration.name}' configuration?");
    if (!await answer) {
      return;
    }

    context.showLoading();
    context
        .read<MosaicoWidgetConfigurationsCoapRepository>()
        .deleteWidgetConfiguration(configurationId: configuration.id!)
        .then((_) => context
            .read<WidgetConfigurationsBloc>()
            .add(LoadWidgetConfigurationsEvent(widgetId: widget.id)))
        .onError((_, __) => Toaster.error('Could not delete configuration'))
        .whenComplete(() => context.hideLoading());
  }

  Future<void> addNewConfiguration(BuildContext context) async {
    // Get configuration form
    context.showLoading();
    context
        .read<MosaicoWidgetsCoapRepository>()
        .getWidgetConfigurationForm(widgetId: widget.id)
        .then((configForm) => _onConfigFormLoaded(context, configForm))
        .onError((_, __) => Toaster.error('Could not load configuration form'))
        .whenComplete(() => context.hideLoading());
  }

  // Called when downloaded configuration form and waiting for user to fill it
  void _onConfigFormLoaded(
      BuildContext context, Map<String, dynamic> configForm) async {
    context.hideLoading();

    // Make user fill the configuration form
    ConfigOutput? generatedConfig = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfigFormPage(configForm),
      ),
    );

    // User dismissed the configuration form
    if (generatedConfig == null) {
      return;
    }

    // Upload the configuration to the matrix
    context.showLoading();
    context
        .read<MosaicoWidgetConfigurationsCoapRepository>()
        .uploadWidgetConfiguration(
            widgetId: widget.id,
            configurationName: generatedConfig.getConfigName(),
            configurationArchivePath: generatedConfig.exportToArchive())
        .then((_) => context
            .read<WidgetConfigurationsBloc>()
            .add(LoadWidgetConfigurationsEvent(widgetId: widget.id)))
        .onError((_, __) => Toaster.error('Could not upload configuration'))
        .whenComplete(() => context.hideLoading());
  }

// /// Downloads the previous configuration and allows the user to edit it
// Future<void> editConfiguration(BuildContext context,
//     MosaicoWidgetConfiguration configuration, MosaicoWidget widget) async {
//   loadingState.showOverlayLoading();
//
//   // Get previous configuration package
//   var oldPackagePath = await _configurationsRepository
//       .getWidgetConfigurationPackage(configurationId: configuration.id!);
//
//   // Get configuration form
//   var configForm = await _widgetsRepository.getWidgetConfigurationForm(
//       widgetId: widget.id);
//   loadingState.hideOverlayLoading();
//
//   // Make user fill the configuration form
//   ConfigOutput? generatedConfig = await Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => ConfigFormPage(configForm,
//           oldConfigDirPath: oldPackagePath,
//           initialConfigName: configuration.name),
//     ),
//   );
//
//   // User dismissed the configuration form
//   if (generatedConfig == null) {
//     return;
//   }
//
//   // Upload the configuration to the matrix
//   loadingState.showOverlayLoading();
//   var updatedConfig =
//       await _configurationsRepository.updateWidgetConfiguration(
//           configurationId: configuration.id!,
//           configurationName: generatedConfig.getConfigName(),
//           configurationArchivePath: generatedConfig.exportToArchive());
//   loadingState.hideOverlayLoading();
//
//   // Update the configuration in the list
//   var index = _configurations!
//       .indexWhere((element) => element.id == configuration.id);
//   _configurations![index] = updatedConfig;
//   notifyListeners();
// }
}
