import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MosaicoTile extends StatelessWidget {

  final Widget? child;
  final List<Widget>? slidableActions;
  const MosaicoTile({super.key, this.child, this.slidableActions});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
        child: Slidable(
            endActionPane: slidableActions == null ? null : ActionPane(
              motion: const ScrollMotion(),
              children: slidableActions!,
            ),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                decoration: const BoxDecoration(
                  color:  Color.fromRGBO(25, 25, 25, 1.0),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                ),
                child: child,
              ),
            )
        )
    );
  }
}
