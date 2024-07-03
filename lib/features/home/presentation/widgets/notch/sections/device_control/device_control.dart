import 'package:flutter/material.dart';

class DeviceControl extends StatelessWidget {
  const DeviceControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Device Control', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary)),
        Slider(
          value: 0,
          onChanged: (double value) {
            // Update the state
          },
          min: 0,
          max: 1,
          divisions: 10,
          label: 'Brightness',
        ),
      ],
    );
  }
}
