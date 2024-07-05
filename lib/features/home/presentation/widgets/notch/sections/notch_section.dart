import 'package:flutter/material.dart';

class NotchSection extends StatelessWidget {
  final String title;
  final Widget child;
  const NotchSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary)),
        child,
      ],
    );
  }
}
