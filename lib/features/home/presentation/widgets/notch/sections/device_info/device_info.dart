import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/home/presentation/widgets/notch/sections/device_info/device_info_key_value.dart';
import 'package:mosaico/features/home/presentation/widgets/notch/sections/notch_section.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatrixDeviceBloc, MatrixDeviceState>(
        builder: (context, state) {
      return NotchSection(
          title: "Device Info",
          child: Column(
            children: [
              DeviceInfoKeyValue(
                  keyText: 'Widget:',
                  valueText: state is MatrixDeviceConnectedState
                      ? state.activeWidget?.name ?? 'N/A'
                      : 'N/A'),
              DeviceInfoKeyValue(
                  keyText: 'Configuration:',
                  valueText: state is MatrixDeviceConnectedState
                      ? state.activeWidgetConfiguration?.name ?? 'N/A'
                      : 'N/A'),
              DeviceInfoKeyValue(
                  keyText: 'Address:',
                  valueText: state is MatrixDeviceConnectedState
                      ? state.address
                      : 'N/A'),
              // GestureDetector(
              //   onDoubleTap: () {
              //     Navigator.pushNamed(context, Routes.debug);
              //   },
              //   child: DeviceInfoKeyValue(
              //       keyText: 'Version:',
              //       valueText: deviceState.deviceVersion),
            ],
          ));
    });
  }
}
