import 'package:flutter/material.dart';

class SlideshowEditorItemCardDuration extends StatelessWidget {
  final Function(int) onDurationChanged;
  final int? initialDuration;
   SlideshowEditorItemCardDuration({super.key, required this.onDurationChanged, this.initialDuration});
  final TextEditingController _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _durationController.text = initialDuration?.toString() ?? '';
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Expanded(
        child: TextFormField(
          controller: _durationController,
          cursorColor: Theme.of(context).colorScheme.onPrimary,
          keyboardType: TextInputType.number,
          decoration:  InputDecoration(
            errorText: checkDuration(),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            filled: true,
            hintText: 'Seconds',
          ),
          onChanged: (value) => value != '' ? onDurationChanged(int.parse(value)) : null,
        ),
      ),
    );
  }

  String? checkDuration() {
    if(_durationController.text == '') {
      return null;
    }

    final int duration = int.parse(_durationController.text);
    if(duration < 5) {
      return 'Duration must be greater than 5 seconds';
    }

    return null;
  }
}
