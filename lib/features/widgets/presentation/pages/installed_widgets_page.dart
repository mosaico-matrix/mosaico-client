import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_state.dart';
import 'package:mosaico/features/store/presentation/widgets/mosaico_store_widget_tile.dart';
import 'package:mosaico/features/widgets/presentation/states/installed_widgets_state.dart';
import 'package:mosaico/shared/widgets/loadable_page.dart';
import 'package:provider/provider.dart';

import '../widgets/mosaico_installed_widget_tile.dart';

class InstalledWidgetsPage extends StatelessWidget {

  InstalledWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final InstalledWidgetsState widgetsState = InstalledWidgetsState();
    return LoadablePage<InstalledWidgetsState>(
      state: widgetsState,
      child: Consumer<InstalledWidgetsState>(
        builder: (context, installedWidgetsState, _) {
          return ListView.builder(
            itemCount: installedWidgetsState.widgets?.length ?? 0,
            itemBuilder: (context, index) {
              return MosaicoInstalledWidgetTile(
                  widget: installedWidgetsState.widgets![index]
              );
            },
          );
        },
      ),
    );
  }
}