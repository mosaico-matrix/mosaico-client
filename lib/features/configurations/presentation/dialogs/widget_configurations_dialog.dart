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
      child: Builder(builder: (context) {
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
                  return _buildConfigurationTiles(
                      context, state.configurations);
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
      }),
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
                  PopupMenuItem(
                    child: ListTile(
                      title: const Text('Edit'),
                      leading: const Icon(Icons.edit),
                      onTap: () => editConfiguration(context, configuration),
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

  Future<void> _loadAndSubmitConfiguration(
      BuildContext context, {
        required Future<Map<String, dynamic>> formLoader,
        required Future<void> Function(String, String) configUploader,
        String? oldConfigDirPath,
        String? oldConfigName,
      }) async {
    context.showLoading();

    // Get configuration form
    formLoader
        .then((configForm) => _onConfigFormLoaded(
        context,
        configForm,
        configUploader: configUploader,
        oldConfigDirPath: oldConfigDirPath,
        oldConfigName: oldConfigName))
        .onError((_, __) => Toaster.error('Could not load configuration form'))
        .whenComplete(() => context.hideLoading());
  }

  Future<void> editConfiguration(
      BuildContext context, MosaicoWidgetConfiguration configuration) async {

    // Close the popup menu
    Navigator.of(context).pop();

    final formLoader = context
        .read<MosaicoWidgetsCoapRepository>()
        .getWidgetConfigurationForm(widgetId: widget.id);

    configUploader(String configName, String configArchivePath) {
      return context
          .read<MosaicoWidgetConfigurationsCoapRepository>()
          .updateWidgetConfiguration(
        configurationId: configuration.id!,
        configurationName: configName,
        configurationArchivePath: configArchivePath,
      );
    }

    // Get previous configuration package
    final oldPackagePath = await context
        .read<MosaicoWidgetConfigurationsCoapRepository>()
        .getWidgetConfigurationPackage(configurationId: configuration.id!);

    // Load and submit the configuration
    await _loadAndSubmitConfiguration(
      context,
      formLoader: formLoader,
      configUploader: configUploader,
      oldConfigDirPath: oldPackagePath,
      oldConfigName: configuration.name,
    );
  }

  Future<void> addNewConfiguration(BuildContext context) async {
    final formLoader = context
        .read<MosaicoWidgetsCoapRepository>()
        .getWidgetConfigurationForm(widgetId: widget.id);

    configUploader(String configName, String configArchivePath) {
      return context
          .read<MosaicoWidgetConfigurationsCoapRepository>()
          .uploadWidgetConfiguration(
        widgetId: widget.id,
        configurationName: configName,
        configurationArchivePath: configArchivePath,
      );
    }

    // Load and submit the new configuration
    await _loadAndSubmitConfiguration(
      context,
      formLoader: formLoader,
      configUploader: configUploader,
    );
  }

  void _onConfigFormLoaded(
      BuildContext context,
      Map<String, dynamic> configForm, {
        required Future<void> Function(String, String) configUploader,
        String? oldConfigDirPath,
        String? oldConfigName,
      }) async {
    context.hideLoading();

    // Make user fill the configuration form
    ConfigOutput? generatedConfig = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfigFormPage(
            configForm,
            oldConfigDirPath: oldConfigDirPath,
            initialConfigName: oldConfigName
        ),
      ),
    );

    // User dismissed the configuration form
    if (generatedConfig == null) {
      return;
    }

    // Upload the configuration using the provided uploader
    context.showLoading();
    configUploader(
      generatedConfig.getConfigName(),
      generatedConfig.exportToArchive(),
    )
        .then((_) => context
        .read<WidgetConfigurationsBloc>()
        .add(LoadWidgetConfigurationsEvent(widgetId: widget.id)))
        .onError((_, __) => Toaster.error('Could not upload configuration'))
        .whenComplete(() => context.hideLoading());
  }

}
