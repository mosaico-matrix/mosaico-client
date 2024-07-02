import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_widget_tile_state.dart';
import 'package:mosaico/shared/widgets/mosaico_widget_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_indicator_small.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:provider/provider.dart';

class MosaicoInstalledWidgetTile extends StatelessWidget {
  final MosaicoWidget widget;
  const MosaicoInstalledWidgetTile({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return MosaicoWidgetTile(widget: widget, trailing: tileTrailing());
  }


  Widget tileTrailing() {
    return DropdownButton<String>(
      items: <String>['Edit', 'Delete'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {

      },
    );
  }
}
