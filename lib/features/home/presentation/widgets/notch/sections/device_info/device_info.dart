import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/widgets/notch/sections/device_info/device_info_key_value.dart';
import 'package:mosaico/features/home/presentation/widgets/notch/sections/notch_section.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/configuration/routes.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MosaicoDeviceState>(
        builder: (context, deviceState, _) {
      return NotchSection(
          title: "Device Info",
          child: Column(
            children: [
              DeviceInfoKeyValue(
                  keyText: 'Widget:', valueText: deviceState.activeWidgetName),
              DeviceInfoKeyValue(
                  keyText: 'Configuration:',
                  valueText: deviceState.activeWidgetConfigurationName),
              DeviceInfoKeyValue(
                  keyText: 'Address:',
                  valueText: deviceState.matrixIp),
              GestureDetector(
                onDoubleTap: () {
                  Navigator.pushNamed(context, Routes.debug);
                },
                child: DeviceInfoKeyValue(
                    keyText: 'Version:', valueText: deviceState.deviceVersion),
              ),
            ],
          ));
    });
  }
}
