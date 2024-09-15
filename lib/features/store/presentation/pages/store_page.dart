import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/store/presentation/widgets/mosaico_store_widget_tile.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/features/mosaico_store/bloc/mosaico_store_bloc.dart';
import 'package:mosaico_flutter_core/features/mosaico_store/bloc/mosaico_store_event.dart';
import 'package:mosaico_flutter_core/features/mosaico_store/bloc/mosaico_store_state.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MosaicoStoreBloc>().add(LoadMosaicoStoreEvent());
    return Scaffold(
      appBar: AppBar(title: const Text('Store')),
      body: Builder(builder: (context) {
        return BlocBuilder<MosaicoStoreBloc, MosaicoStoreState>(
          builder: (context, state) {

            // Widgets ready
            if (state is MosaicoStoreLoadedState) {
              return ListView.builder(
                itemCount: state.storeWidgets.length,
                itemBuilder: (context, index) {
                  return MosaicoStoreWidgetTile(widget: state.storeWidgets[index]);
                },
              );
            }

            // Error
            if (state is MosaicoStoreErrorState) {
              return EmptyPlaceholder(
                hintText: state.message,
                onRetry: () {
                  context
                      .read<MosaicoStoreBloc>()
                      .add(LoadMosaicoStoreEvent());
                },
              );
            }

            // Loading
            return Center(child: Center(child: LoadingMatrix()));
          },
        );
      }),
    );
  }
}
