import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';

class MosaicoWidgetTile extends StatelessWidget {

  final MosaicoWidget widget;
  final Widget? trailing;
  final List<Widget> slidableActions;
  const MosaicoWidgetTile({super.key, required this.widget, this.trailing, required this.slidableActions});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
            child: Slidable(
                endActionPane: slidableActions.isEmpty ? null : ActionPane(
                  motion: const ScrollMotion(),
                  children: slidableActions,
                ),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.widgets),
                    title: Text(widget.name),
                    subtitle: widget.description == '' ? null : Text(
                        widget.description),
                    trailing: trailing,
                  ),
                )
            )
        )
    );
  }
}
