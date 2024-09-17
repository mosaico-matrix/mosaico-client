import 'package:flutter/material.dart';
import 'package:parallax_rain/parallax_rain.dart';

class PixelRain extends StatelessWidget {
  final Widget child;

  const PixelRain({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ParallaxRain(
        numberOfDrops: 100,
        dropFallSpeed: 0.2,
        dropHeight: 0.8,
        dropColors: const [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
        ],
        child: child);
  }
}
