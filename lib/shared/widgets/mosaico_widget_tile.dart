import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/core/configuration/routes.dart';
import 'package:mosaico/shared/widgets/mosaico_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';

class MosaicoWidgetTile extends StatelessWidget {

  final MosaicoWidget widget;
  final Widget? trailing;
  const MosaicoWidgetTile({super.key, required this.widget, this.trailing});

  @override
  Widget build(BuildContext context) {
    return  MosaicoTile(
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
          subtitle: Text(
              widget.tagline != '' ? widget.tagline : widget.author,
              style: const TextStyle(fontSize: 10, color: Colors.white)),
          trailing: trailing
        ),
    );

  }
}
