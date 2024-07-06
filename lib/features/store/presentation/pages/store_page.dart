import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_state.dart';
import 'package:mosaico/features/store/presentation/widgets/mosaico_store_widget_tile.dart';
import 'package:mosaico/main.dart';
import 'package:mosaico/shared/widgets/loadable_page.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {

  StorePage({super.key});

  @override
  Widget build(BuildContext context) {

    final StoreState storeState = StoreState(
      installedWidgetsState: Provider.of(context, listen: false),
    );

    return LoadablePage<StoreState>(
      appBar:AppBar(title:  const Text('Store')),
      state: storeState,
      child: Consumer<StoreState>(
        builder: (context, storeState, _) {
          return ListView.builder(
            itemCount: storeState.widgets?.length ?? 0,
            itemBuilder: (context, index) {
              return MosaicoStoreWidgetTile(
                  widget: storeState.widgets![index]
              );
            },
          );
        },
      ),
    );
  }
}