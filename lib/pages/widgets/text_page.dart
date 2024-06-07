import 'package:flutter/material.dart';
import 'package:magicsquare/configuration/configs.dart';
import 'package:magicsquare/models/api/text.dart' as TextModel;
import 'package:magicsquare/pages/widgets/widget_page.dart';
import 'package:magicsquare/services/text_service.dart';
import 'package:magicsquare/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import '../../configuration/runners.dart';
import '../../widgets/dialogs/text_input_dialog.dart';

class TextPage extends WidgetPage<TextModel.Text> {
  TextPage({super.key})
      : super(widgetType: MatrixWidgetEnum.TEXT, pageState: _TextPageState());

  @override
  Future<TextModel.Text?> createModelApi() async {
    return await TextService.createText(widgetModel!);
  }

  @override
  Future<TextModel.Text?> getModelApi() async {
    return await TextService.getText(widgetId!);
  }

  @override
  TextModel.Text initNewModel() {
    return TextModel.Text(
      lines: [
        TextModel.TextLine(
          text: "Hey",
          fontHeight: 6,
          color: 'ffffff',
          textId: widgetModel!.id,
        )
      ],
      name: 'Testo',
    );
  }

  @override
  Future<TextModel.Text?> updateModelApi() async {
    return await TextService.updateText(widgetId!, widgetModel!);
  }
}

class _TextPageState extends WidgetPageState<TextModel.Text> {
  static const int _maxLines = 5;

  @override
  Widget getPageContent(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.widgetModel?.lines.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.black,
                child: ListTile(
                    leading: leadingContent(index),
                    title: textLine(index),
                    trailing: trailingButtons(index)),
              );
            }),
        Visibility(
          visible: widget.widgetModel!.lines.length < _maxLines,
          child: ElevatedButton(
            onPressed: _addTextLine,
            child: const Text("Aggiungi riga"),
          ),
        )
      ],
    );
  }

  /// Returns a dropdown with the available font sizes
  Widget leadingContent(int index) {
    return DropDown(
      items: [for (int i in Configs.availableFontSizes) i.toString()],
      hint: Text(widget.widgetModel!.lines[index].fontHeight.toString(),
          style: const TextStyle(color: Colors.white)),
      customWidgets: [
        for (int i in Configs.availableFontSizes)
          Text(i.toString(), style: const TextStyle(color: Colors.white))
      ],
      icon: const Icon(Icons.text_fields_rounded),
      onChanged: (value) {
        setState(() {
          widget.widgetModel!.lines[index].fontHeight = int.parse(value!);
        });
      },
    );
  }

  /// Returns a row with two buttons: one for changing the color and one for deleting the line
  Widget trailingButtons(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        // Color button
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.color_lens, color: Colors.white),
          onPressed: () async {
            //   await ColorPickerDialog.show(context, (color) {
            //     setState(() {
            //       // Remove alpha
            //       widget.widgetModel!.lines[index].color =
            //           colorToHex(color).substring(2);
            //     });
            //   }, initialColor: colorFromHex(widget.widgetModel?.lines[index].color));
            // },
          }
        ),

        // Delete button
        IconButton(
            padding: EdgeInsets.zero,
            icon:
                const Icon(color: Colors.red, Icons.delete), // Delete button
            onPressed: () => _deleteLineAt(index)),
      ],
    );
  }

  /// Returns a text line widget, the middle part of the list tile
  Widget textLine(int index) {
    return TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        style: const TextStyle(
            fontSize: 24,
            color: Colors.red), // colorFromHex(widget.widgetModel!.lines[index].color)),
        onChanged: (text) {
          widget.widgetModel!.lines[index].text = text;
        },
        controller: TextEditingController(
          text: widget.widgetModel!.lines[index].text,
        ));
  }

  /// Add a new line to the text widget
  _addTextLine() {
    // Return if we reached the maximum number of lines
    if (widget.widgetModel!.lines.length >= _maxLines) {
      return;
    }

    // Add a new line
    setState(() {
      widget.widgetModel!.lines.add(TextModel.TextLine(
        text: "Hey",
        fontHeight: 6,
        color: 'ffffff',
        textId: widget.widgetModel!.id,
      ));
    });
  }

  /// Delete a line from the text widget
  _deleteLineAt(int index) {
    // Ask for confirm
    ConfirmationDialog.show(context, "Sicuro", "Di eliminare", () {
      setState(() {
        widget.widgetModel!.lines.removeAt(index);
      });
    });
  }

  @override
  void onEditClicked() {
    TextInputDialog.show(context, "Nome del testo", (name) {
      setState(() {
        widget.widgetModel!.name = name;
      });
    });
  }
}
