import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/led_matrix.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:provider/provider.dart';

import 'device_status_label.dart';
import 'device_status_pulse.dart';

class DeviceStatus extends StatelessWidget {
  const DeviceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceState = Provider.of<MosaicoDeviceState>(context);
    return deviceState.isConnecting
        ? const LedMatrix()
        : const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LedMatrix(),
              SizedBox(width: 15),
              DeviceStatusLabel(),
              DeviceStatusPulse(),
            ],
          );
  }
}
