import 'package:flutter/material.dart';
import 'package:mosaico/features/home/presentation/widgets/buttons/home_buttons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/notch/device_notch.dart';

class Home extends StatelessWidget {
  static const double notchHeight = 150.0;

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          body: SlidingUpPanel(
        slideDirection: SlideDirection.DOWN,
        minHeight: notchHeight,
        parallaxEnabled: true,
        parallaxOffset: 1,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        panel: const Center(
          child: DeviceStatusNotch(),
        ),
        body: const Center(
          child: Column(
            children: [
              SizedBox(height: notchHeight),
              Spacer(),
              HomeButtons(),
              Spacer()
            ],
          ),
        ),
      ));
    });
  }
}
