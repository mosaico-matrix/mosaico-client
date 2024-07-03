import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/widgets/notch/sections/device_status/device_status.dart';
import 'package:mosaico_flutter_core/features/matrix_control/presentation/states/mosaico_device_state.dart';
import 'package:provider/provider.dart';

class DeviceStatusNotch extends StatelessWidget {
  const DeviceStatusNotch({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MosaicoDeviceState>(context, listen: false).connect();
    });

    return const Padding(
      padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DeviceStatus(),
          SizedBox(height: 10),
          PullBar()
        ],
      ),
    );
  }
}

class PullBar extends StatelessWidget {
  const PullBar({super.key});

  @override
  Widget build(BuildContext context) {
    return // Pull bar
      Container(
        width: 100,
        height: 4,
        decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
