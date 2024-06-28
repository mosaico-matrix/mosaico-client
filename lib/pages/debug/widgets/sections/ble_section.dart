
import 'package:flutter/material.dart';

import '../../debug.dart';

class BleSection extends StatelessWidget {
  const BleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DebugSubSection(
          title: "Matrix",
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Send network credentials'),
            ),
          ],
        ),
      ],
    );
  }
}