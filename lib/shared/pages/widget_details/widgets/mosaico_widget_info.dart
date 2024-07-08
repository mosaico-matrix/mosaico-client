import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_heading.dart';

class MosaicoWidgetInfo extends StatelessWidget {


  const MosaicoWidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MosaicoHeading(text: 'Info'),
        Divider(),
      ],
    );
  }
}
