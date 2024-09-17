import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';

class DeviceStatusPulse extends StatelessWidget {
  const DeviceStatusPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatrixDeviceBloc, MatrixDeviceState>(
        builder: (context, state){
          if (state is MatrixDeviceConnectedState) {
            return _buildPulse(context, true);
          } else {
            return _buildPulse(context, false);
          }
        });
  }

  Widget _buildPulse(BuildContext context, bool connected) {
    return Lottie.asset(
      connected
          ? 'assets/lottie/green-pulse.json'
          : 'assets/lottie/red-pulse.json',
      width: 70,
      fit: BoxFit.contain,
      height: 70,
    );
  }
}
