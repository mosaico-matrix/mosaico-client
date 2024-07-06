import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mosaico/core/configuration/routes.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';

class MosaicoWidgetTile extends StatelessWidget {

  final MosaicoWidget widget;
  final Widget? trailing;
  final List<Widget>? slidableActions;
  MosaicoWidgetTile({super.key, required this.widget, this.trailing, this.slidableActions});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.widgetDetails, arguments: widget);
          },
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
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: widget.iconUrl,
                        width: 50,
                        height: 50,
                      ),
                      title: AutoSizeText(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 20,
                              fontWeight: FontWeight.bold
                          )),
                      subtitle: Text(widget.tagline != '' ? widget.tagline : widget.author, style: const TextStyle(fontSize: 10)),
                      trailing: trailing,
                    ),
                  ),
                )
            )
        )
    );
  }
}
