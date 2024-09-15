import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';

class DeviceStatusLabel extends StatelessWidget {
  const DeviceStatusLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<MatrixDeviceBloc, MatrixDeviceState>(
              builder: (context, state) {
                if (state is MatrixDeviceConnectedState) {
                  return _buildHeadingStatusLabel("Connected", context);
                } else if (state is MatrixDeviceConnectingState) {
                  return _buildHeadingStatusLabel("Connecting", context);
                } else {
                  return _buildHeadingStatusLabel("Disconnected", context);
                }
              },
            ),
            BlocBuilder<MatrixDeviceBloc, MatrixDeviceState>(
              builder: (context, state) {

                // When we'connected, we don't need to show BLE status
                if (state is MatrixDeviceConnectedState) {
                  return _buildSecondLineStatusLabel(state.activeWidget?.name ?? "No active widget", context);
                }

                if (state is MatrixDeviceDisconnectedState &&
                    state.bleConnected) {
                  return _buildSecondLineStatusLabel("BLE Connected", context);
                } else if (state is MatrixDeviceConnectingState) {
                  return _buildSecondLineStatusLabel("BLE Connecting", context);
                } else {
                  return _buildSecondLineStatusLabel("BLE Disconnected", context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadingStatusLabel(String text, BuildContext context) {
    return AutoSizeText(text,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary),
        maxLines: 1);
  }

  Widget _buildSecondLineStatusLabel(String text, BuildContext context) {
    return AutoSizeText(text,
        style: TextStyle(
            fontSize: 10, color: Theme.of(context).colorScheme.onPrimary),
        maxLines: 1);
  }
}
