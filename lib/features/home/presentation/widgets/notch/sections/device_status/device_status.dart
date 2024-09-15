import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/home/presentation/states/home_page_state.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_event.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
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
    return BlocBuilder<MatrixDeviceBloc, MatrixDeviceState>(
      builder: (context, state) {
        if (state is MatrixDeviceConnectedState ||
            state is MatrixDeviceConnectingState) {

          return Row(
            children: [
              LoadingMatrix(ledHeight: 6, n: 8),
              const SizedBox(width: 15),
            ],
          );
        } else {
          return _retryButton(context);
        }
      },
    );
  }

  Widget _retryButton(BuildContext context) {
    return IconButton(
      iconSize: HomePageState.notchHeight * 0.3,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
      ),
      icon: const Icon(Icons.refresh),
      onPressed: () async {
        context.read<MatrixDeviceBloc>().add(ConnectToMatrixEvent());
      },
    );
  }
}
