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
      child: SingleChildScrollView(
        child: Column(
          children: [
            MosaicoButton(
              icon: Icons.stop,
              onPressed: () async {
                await deviceState.stopActiveWidget();
              },
              text: "Stop active widget",
            ),
            MosaicoButton(
              icon: Icons.wifi,
              onPressed: () async {
                await deviceState.sendNetworkCredentials(context);
              },
              text: "Send WiFi credentials",
            ),
            MosaicoButton(
              icon: Icons.edit,
              onPressed: () async {
                await deviceState.setManualMatrixIp(context);
              },
              text: "Set manual matrix address",
            ),
          ],
        ),
      ),
    );
  }
}
