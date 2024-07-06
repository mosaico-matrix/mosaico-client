import 'package:flutter/material.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico/shared/widgets/loadable_page.dart';
import 'package:provider/provider.dart';

import '../widgets/mosaico_installed_widget_tile.dart';

class InstalledWidgetsPage extends StatelessWidget {

  InstalledWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadablePage<InstalledWidgetsState>(
      noDataHintText: 'Visit the store to discover new widgets!',
      state: Provider.of(context, listen: false),
      child: Consumer<InstalledWidgetsState>(
        builder: (context, installedWidgetsState, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: installedWidgetsState.widgets.length,
            itemBuilder: (context, index) {
              return MosaicoInstalledWidgetTile(
                  widget: installedWidgetsState.widgets[index]
              );
            },
          );
        },
      ),
    );
  }
}