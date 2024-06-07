import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:magicsquare/networking/tcp_client.dart';
import 'package:magicsquare/services/text_service.dart';
import '../configuration/runners.dart';

class ListCell extends StatelessWidget {
  final String title;
  final MatrixWidgetEnum widgetType;
  final int widgetId;
  final String editRoute;

  const ListCell({super.key, required this.title, required this.widgetType, required this.widgetId, required this.editRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, editRoute, arguments: widgetId),
      child: Slidable(

        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) => TCPClient.displayWidget(widgetType, widgetId),
              backgroundColor: const Color(0xFF00C3FF),
              foregroundColor: Colors.white,
              icon: Icons.play_arrow,
            ),
            SlidableAction(
              onPressed: (BuildContext context) => TextService.deleteText(widgetId),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border:
            const Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: ListTile(
                title: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
        ),
      ),
    );
  }
}
