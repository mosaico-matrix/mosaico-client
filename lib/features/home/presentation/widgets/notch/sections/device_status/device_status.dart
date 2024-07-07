import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'device_status_label.dart';
import 'device_status_pulse.dart';

class DeviceStatus extends StatelessWidget {
  const DeviceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoadingMatrix(ledHeight: 6, n: 8),
        const SizedBox(width: 15),
        const DeviceStatusLabel(),
        const DeviceStatusPulse(),
      ],
    );
  }
}
