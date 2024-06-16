// Create button dart component with gradient background
// Path: lib/widgets/dash_button.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/blurred_carousel_menu.dart';
import '../../../widgets/carousel_menu_item.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final Color startColor;
  final Color endColor;
  final List<CarouselMenuItem> menuItems;

  const DashboardButton(
      {super.key,
      required this.title,
      required this.startColor,
      required this.endColor,
      this.menuItems = const []});

  // Animation params
  final int _shimmerDuration = 2;
  final int _minDelay = 2;
  final int _maxDelay = 8;

  int getDelayBeforeAnimation() {
    return Random().nextInt(_maxDelay - _minDelay) + _minDelay;
  }

  @override
  Widget build(BuildContext context) {
    return

        // Outside box for gradient
        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [startColor, endColor],
                begin: Alignment.topLeft, // Your gradient startfl
                end: Alignment.bottomRight, // Your gradient end
              ),
              borderRadius: BorderRadius.circular(18.0),
            ),

            // Padding before button to make effect of gradient border
            child: Padding(
                padding: const EdgeInsets.all(1),

                // Actual button
                child: FilledButton(
                    onPressed: () => openModal(context),

                    // Style and rounded corners
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),

                    // Widget content
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 5),
                        child: Text(title,
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.white))
                            .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: false))
                            .tint(color: Colors.white)
                            .then(delay: getDelayBeforeAnimation().seconds)
                            .shimmer(colors: [
                          Colors.white,
                          startColor,
                          endColor,
                          Colors.white
                        ], duration: _shimmerDuration.seconds)))));
  }

  // Open modal
  void openModal(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return BlurredCarouselMenu(menuItems: menuItems, title: title);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: BlurTransition(
                animation: animation,
                child: child,
              ),
            );
          },
        ));
  }
}
