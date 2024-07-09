import 'package:flutter/material.dart';
import 'package:mosaico/features/widgets/presentation/states/widget_configuration_editor_state.dart';
import 'package:mosaico/features/widgets/presentation/widgets/mosaico_configuration_tile.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_button.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_text_button.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:provider/provider.dart';

class WidgetConfigurationEditor extends StatelessWidget {
  final MosaicoWidget widget;
  const WidgetConfigurationEditor({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    var loadingState = context.watch<MosaicoLoadingState>();

    return ChangeNotifierProvider(
        create: (context) => WidgetConfigurationEditorState(loadingState),
        child: Consumer<WidgetConfigurationEditorState>(
          builder: (context, state, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              state.loadConfigurations(widget);
            });
            return AlertDialog(
              title: const Text('Configurations'),
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
                    onPressed: () =>
                        state.addNewConfiguration(context, widget)),
              ],
              content: state.configurations.isEmpty
                  ? const EmptyPlaceholder()
                  : Column(
                      children: state.configurations.map((configuration) {
                        return MosaicoConfigurationTile(
                            configuration: configuration,
                            trailing:
                            PopupMenuButton(
                              itemBuilder: (context) => [

                                PopupMenuItem(
                                  child: ListTile(
                                      title: const Text('Edit'),
                                      leading: const Icon(Icons.edit),
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        await state.editConfiguration(
                                            context, configuration, widget);
                                      }),
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                      title: const Text('Delete'),
                                      leading: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        await state.deleteConfiguration(
                                            context, configuration);
                                      }),
                                ),
                              ],
                            )

                        );
                      }).toList(),
                    ),
            );
          },
        ));
  }
}
