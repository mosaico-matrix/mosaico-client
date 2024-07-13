import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_heading.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MosaicoWidgetInfo extends StatelessWidget {
  final MosaicoWidget mosaicoWidget;

  const MosaicoWidgetInfo({super.key, required this.mosaicoWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MosaicoHeading(text: 'Info'),
        const Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MosaicoHeading(text: 'Author'),
            Text(mosaicoWidget.author),
            const MosaicoHeading(text: 'Repo URL'),
            Linkify(
              onOpen: (link) async {
                if (!await launchUrl(Uri.parse(link.url))) {
                  throw Exception('Could not launch ${link.url}');
                }
              },
              text: "${mosaicoWidget.repositoryUrl}",
              linkStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        )
      ],
    );
  }
}
