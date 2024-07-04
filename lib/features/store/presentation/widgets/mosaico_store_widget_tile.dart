import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_widget_tile_state.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_indicator_small.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:provider/provider.dart';

class MosaicoStoreWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;

  const MosaicoStoreWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreWidgetTileState(),
      child: Consumer<StoreWidgetTileState>(
          builder: (context, widgetTileState, _) {
        return MosaicoWidgetTile(
            widget: widget, trailing: tileTrailing(widgetTileState));
      }),
    );
  }

  /// Install widget button or checkmark
  Widget tileTrailing(StoreWidgetTileState widgetTileState) {

    // Show loading indicator
    if (widgetTileState.isInstalling) {
      return MosaicoLoadingIndicatorSmall();
    }

    // Show checkmark
    if (widget.installed) {
      return const Icon(Icons.check);
    }

    // Show install button
    return IconButton(
      icon: const Icon(Icons.download),
      onPressed: () {
        widgetTileState.installWidget(widget);
      },
    );
  }
}
