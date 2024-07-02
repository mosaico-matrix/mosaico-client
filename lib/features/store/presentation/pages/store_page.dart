import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_state.dart';
import 'package:mosaico/features/store/presentation/widgets/mosaico_store_widget_tile.dart';
import 'package:mosaico/shared/widgets/loadable_page.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';

class StorePage extends StatelessWidget {

  final StoreState storeState = StoreState();
  StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadablePage<StoreState>(
      title: "Store",
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