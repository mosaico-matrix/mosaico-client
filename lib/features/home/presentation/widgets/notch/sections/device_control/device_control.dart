import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_button.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:provider/provider.dart';

import '../notch_section.dart';

class DeviceControl extends StatelessWidget {
  const DeviceControl({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceState = Provider.of<MosaicoDeviceState>(context);

    return NotchSection(
        title: "Device Control",
        child: Column(
          children: [
            MosaicoButton(
              icon: Icons.stop,
                onPressed: () async {
              await deviceState.stopActiveWidget();
            }, text: "Stop active widget"),
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
        ));
  }
}
