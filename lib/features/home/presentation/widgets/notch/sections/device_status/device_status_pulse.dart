import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:provider/provider.dart';

class DeviceStatusPulse extends StatelessWidget {
  const DeviceStatusPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MosaicoDeviceState>(builder: (context, state, child) {
      return Lottie.asset(
        state.isConnected
            ? 'assets/lottie/green-pulse.json'
            : 'assets/lottie/red-pulse.json',
        width: 70,
        fit: BoxFit.contain,
        height: 70,
      );
    });
  }
}
