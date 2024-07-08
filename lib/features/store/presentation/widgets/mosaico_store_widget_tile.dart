import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_state.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:provider/provider.dart';

class MosaicoStoreWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;
  const MosaicoStoreWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    var widgetTileState = Provider.of<StoreState>(context);
    return MosaicoWidgetTile(
        widget: widget, trailing: tileTrailing(widgetTileState));
  }

  /// Install widget button or checkmark
  Widget tileTrailing(StoreState storeState) {

    // Show loading indicator
    if (storeState.isInstalling(widget.storeId!)) {
      return LoadingMatrix(ledHeight: 5, n: 4);
    }

    // Show checkmark
    if (widget.installed) {
      return const Icon(Icons.check);
    }

    // Show install button
    return IconButton(
      icon: const Icon(Icons.download),
      onPressed: () {
        storeState.installWidget(widget);
      },
    );
  }
}
