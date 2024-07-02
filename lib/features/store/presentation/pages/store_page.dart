import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_state.dart';
import 'package:mosaico/features/store/presentation/widgets/mosaico_store_widget_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreState>(
      create: (context) => StoreState(Provider.of<MosaicoLoadingState>(context, listen: false)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Store'),
        ),
        body: Consumer<StoreState>(
          builder: (context, storeState, child) {
            
            var isLoading = Provider.of<MosaicoLoadingState>(context).isLoading;

            // Get widgets after the widget is built
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await storeState.init();
            });

            // Show loading
            if (isLoading) {
              return Center(child: MosaicoLoadingIndicator());
            }

            // Empty
            if (storeState.widgets?.isEmpty ?? true) {
              return const EmptyPlaceholder();
            }

            // Display widgets
            return ListView.builder(
                    itemCount: storeState.widgets?.length ?? 0,
                    itemBuilder: (context, index) {
                      return MosaicoStoreWidgetTile(widget: storeState.widgets![index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
