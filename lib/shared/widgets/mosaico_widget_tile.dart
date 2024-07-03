import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';

class MosaicoWidgetTile extends StatelessWidget {

  final MosaicoWidget widget;
  final Widget? trailing;
  const MosaicoWidgetTile({super.key, required this.widget, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.widgets),
          title: Text(widget.name),
          subtitle: widget.description == '' ? null : Text(widget.description),
          trailing: trailing,
        ),
      ),
    );
  }
}
