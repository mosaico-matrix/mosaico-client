import 'package:flutter/cupertino.dart';
import 'package:mosaico/widgets/led_matrix.dart';

class MatrixProgressIndicator extends StatelessWidget
{
  const MatrixProgressIndicator({super.key});

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