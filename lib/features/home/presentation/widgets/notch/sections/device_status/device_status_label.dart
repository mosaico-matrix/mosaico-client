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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(state.coapConnectionStatusText,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                  maxLines: 1),
              Visibility(
                child: AutoSizeText(
                  state.bleConnectionStatusText,
                  style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onPrimary),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
