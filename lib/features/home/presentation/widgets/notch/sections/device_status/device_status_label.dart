import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:provider/provider.dart';

class DeviceStatusLabel extends StatelessWidget {
  const DeviceStatusLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MosaicoDeviceState>(builder: (context, state, child) {
      return Expanded(
        child: Center(
          child:  AutoSizeText(
            state.statusLabel,
            style: TextStyle(fontSize: 40, color: Theme.of(context).colorScheme.onPrimary),
            maxLines: 1,
          ),
        ),
      );
    });
  }
}
