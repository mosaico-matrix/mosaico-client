import 'package:flutter/material.dart';

class DeviceInfoKeyValue extends StatelessWidget {
  final String keyText;
  final String valueText;

  const DeviceInfoKeyValue({super.key, required this.keyText, required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          keyText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          valueText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}