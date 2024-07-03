import 'package:flutter/material.dart';

import '../../../../../../../core/configuration/routes.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pushNamed(context, Routes.debug);
      },
      child: Column(
        children: [
          Text('Device Info', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary)),
          Text('Device name: Mosaico', style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onPrimary)),
          Text('Device version: 1.0.0', style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onPrimary)),
        ],
      ),
    );
  }
}
