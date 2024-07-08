import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_heading.dart';

class MosaicoWidgetDescription extends StatelessWidget {

  final String description;
  const MosaicoWidgetDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {



    return Column(
      children: [
        const MosaicoHeading(text: 'Description'),
        const Divider(),
        MarkdownBody(data: description, styleSheet: MarkdownStyleSheet.fromTheme(

          // Edit a bit the theme
          Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white
            ) )
        )),
      ],
    );
  }
}
