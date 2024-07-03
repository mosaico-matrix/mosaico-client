import 'package:flutter/material.dart';
import 'package:mosaico/core/configuration/constants.dart';
import 'package:mosaico/features/home/presentation/widgets/buttons/home_buttons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/notch/device_notch.dart';

double a = 0.3;
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          body: SlidingUpPanel(
        slideDirection: SlideDirection.DOWN,
        minHeight: Constants.notchHeight,
        parallaxEnabled: true,
        parallaxOffset: 1,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        panel: const Center(
          child: DeviceStatusNotch(),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: Constants.notchHeight),
              const Spacer(),
              const HomeButtons(),
              const Spacer()
            ],
          ),
        ),
      ));
    });
  }
}
