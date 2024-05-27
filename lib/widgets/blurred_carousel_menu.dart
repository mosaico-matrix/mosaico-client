// Modal widget for the carousel menu
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:magicsquare/widgets/carousel_menu_item.dart';

class BlurredCarouselMenu extends StatelessWidget {
  final List<CarouselMenuItem> menuItems;
  final String title;
  const BlurredCarouselMenu({super.key, required this.menuItems, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menuItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
                child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: menuItems[index].buildWidget(context),
            ));
          },
        ),
      ),
    );
  }
}

class BlurTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  BlurTransition({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
          sigmaX: 5 * animation.value, sigmaY: 5 * animation.value),
      child: child,
    );
  }
}
