import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/led_matrix.dart';

import 'device_status_label.dart';
import 'device_status_pulse.dart';

class DeviceStatus extends StatelessWidget {
  const DeviceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LedMatrix(),
        SizedBox(width: 15), // Adjust the distance between the LED matrix and the device status
        DeviceStatusLabel(),
        DeviceStatusPulse(),
      ],
    );
  }
}
