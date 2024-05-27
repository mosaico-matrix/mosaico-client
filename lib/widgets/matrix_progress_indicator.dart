import 'package:flutter/cupertino.dart';
import 'package:magicsquare/widgets/led_matrix.dart';

class MatrixProgressIndicator extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LedMatrix(
        n: 4,
        ledHeight: 10,
        ledSpacing: 2,
        repeatAnimationEvery: 200,
      ),
    );
  }
}