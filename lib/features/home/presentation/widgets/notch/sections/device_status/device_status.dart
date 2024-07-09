import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/states/home_page_state.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:provider/provider.dart';
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
        _matrixOrRetryButton(context),
        const DeviceStatusLabel(),
        const DeviceStatusPulse(),
      ],
    );
  }

  Widget _matrixOrRetryButton(BuildContext context) {
    var deviceState = Provider.of<MosaicoDeviceState>(context);
    if(deviceState.isConnected || deviceState.isConnecting) {
      return Row(
        children: [
          LoadingMatrix(ledHeight: 6, n: 8),
          const SizedBox(width: 15),
        ],
      );
    } else {
      return IconButton(
        iconSize: HomePageState.notchHeight * 0.3,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
        ),
        icon: const Icon(Icons.refresh),
        onPressed: () async => await deviceState.retryConnection(),
      );
    }
  }
}
