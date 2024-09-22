import 'package:flutter/material.dart';

class SlideshowEditorItemCardHeading extends StatelessWidget {
  final int position;
  const SlideshowEditorItemCardHeading({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Text(
        style: const TextStyle(fontSize: 20), "Widget ${position + 1}");
  }
}
