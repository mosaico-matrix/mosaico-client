import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputDialog
{
  static Future<void> show(BuildContext context, String heading, Function(String) onTextEntered) async {
    String enteredText = '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(heading),
          content: CupertinoTextField(
            onChanged: (value) {
              enteredText = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the callback function with the entered text
                onTextEntered(enteredText);
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}