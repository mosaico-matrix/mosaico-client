import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/widgets/notch/sections/device_control/device_control.dart';
import 'package:mosaico/features/home/presentation/widgets/notch/sections/device_info/device_info.dart';
import 'package:mosaico/features/home/presentation/widgets/notch/sections/device_status/device_status.dart';
import 'package:provider/provider.dart';

class DeviceStatusNotch extends StatelessWidget {

  const DeviceStatusNotch({super.key});

  @override
  Widget build(BuildContext context) {

    return const Padding(
      padding: EdgeInsets.only(bottom: 10, left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DeviceControl(),
          SizedBox(height: 15),
          Divider(color: Colors.grey),
          SizedBox(height: 15),
          DeviceInfo(),
          SizedBox(height: 15),
          Divider(color: Colors.grey),
          SizedBox(height: 50),
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
