import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/dialogs/text_input_dialog.dart';
import 'package:mosaico_flutter_core/common/widgets/mosaico_button.dart';
import 'package:mosaico_flutter_core/core/networking/services/coap/coap_service.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_event.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:provider/provider.dart';

import '../notch_section.dart';

class DeviceControl extends StatelessWidget {
  const DeviceControl({super.key});

  @override
  Widget build(BuildContext context) {
    return NotchSection(
      title: "Device Control",
      child: SingleChildScrollView(
        child: Column(
          children: [
            MosaicoButton(
              icon: Icons.stop_circle_outlined,
              onPressed: () async {
                _stopPlayback(context);
              },
              text: "Stop playback",
            ),
            // MosaicoButton(
            //   icon: Icons.wifi,
            //   onPressed: () async {
            //     //await deviceState.sendNetworkCredentials(context);
            //   },
            //   text: "Send WiFi credentials",
            // ),
            MosaicoButton(
              icon: Icons.edit,
              onPressed: () async {
                _setMatrixIp(context);
              },
              text: "Set manual matrix address",
            ),
          ],
        ),
      ),
    );
  }

  void _stopPlayback(BuildContext context) {
    var deviceState = context.read<MatrixDeviceBloc>().state;
    if (deviceState is! MatrixDeviceConnectedState) {
      Toaster.error("You are not connected to a matrix device");
      return;
    }

    context
        .read<MosaicoWidgetsCoapRepository>()
        .unsetActiveWidget()
        .then((value) {
      // Update state
      context.read<MatrixDeviceBloc>().add(UpdateMatrixDeviceStateEvent(
          deviceState.copyWith(
              activeWidget: null, activeWidgetConfiguration: null)));
    }).catchError((error) {
      Toaster.error("Could not stop playback");
    });
  }

  void _setMatrixIp(BuildContext context) async {
    // Request the address to the user
    var address =
        await TextInputDialog.show(context, "Enter the matrix address");

    if (address == null) return;

    // Show loading
    context.read<MosaicoLoadingState>().showOverlayLoading();


    // Check if matrix is reachable at address
    CoapService.pingMatrix(address).then((reachable) {
      if (!reachable) {
        Toaster.error("Matrix not reachable at given address");
        return;
      }

      Toaster.success("Matrix found!");

      // Try to connect
      context
          .read<MatrixDeviceBloc>()
          .add(ConnectToMatrixEvent(address: address));
    }).whenComplete(() {
      // Hide loading
      context.read<MosaicoLoadingState>().hideOverlayLoading();
    });
  }
}
