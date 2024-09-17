import 'package:flutter/material.dart';
import 'package:mosaico/features/store/bloc/mosaico_store_bloc.dart';
import 'package:mosaico/features/store/bloc/mosaico_store_event.dart';
import 'package:mosaico/features/store/bloc/mosaico_store_state.dart';
import 'package:mosaico/features/store/presentation/pages/store_detail_page.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:provider/provider.dart';

class MosaicoStoreWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;

  const MosaicoStoreWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StoreDetailPage(
                      widget: widget,
                    )));
      },
      child: MosaicoWidgetTile(
        widget: widget,
        trailing: tileTrailing(context),
      ),
    );
  }

  // Install widget button or checkmark
  Widget tileTrailing(BuildContext context) {
    // Check if connected to the matrix
    final deviceState = context
        .read<MatrixDeviceBloc>()
        .state;

    // We're not connected to a matrix
    if (deviceState is! MatrixDeviceConnectedState) {
      return const Tooltip(
        triggerMode: TooltipTriggerMode.tap,
        message: 'You need to connect to a matrix to install widgets',
        showDuration: const Duration(seconds: 5),
        child: Icon(Icons.warning),
      );
    }

    // Get store state
    final storeState = context
        .read<MosaicoStoreBloc>()
        .state;

    // Store is not ready
    if (storeState is! MosaicoStoreLoadedState) {
      return const SizedBox.shrink();
    }

    // We are installing this very widget
    if (storeState.installingWidgetId == widget.storeId) {
      return LoadingMatrix(ledHeight: 5, n: 4);
    }

    // This widget is already installed
    if (storeState.installedWidgets
        .where((w) => w.storeId == widget.storeId)
        .isNotEmpty) {
      return const Icon(Icons.check);
    }

    // We are installing another widget, don't show install button
    if (storeState.installingWidgetId != null) {
      return const SizedBox.shrink();
    }

    // We can install this widget
    return IconButton(
        icon: const Icon(Icons.download),
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: () {
          context.read<MosaicoStoreBloc>().add(InstallMosaicoWidgetEvent(
              storeId: widget.id, previousState: storeState));
        });
  }
}
