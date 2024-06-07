
import 'package:flutter/src/widgets/framework.dart';
import 'package:magicsquare/models/api/serializable.dart';
import 'package:magicsquare/models/api/widgetable.dart';
import 'package:flutter/material.dart' as material;

class Text implements Widgetable {

  @override
  int id;
  String name;
  int marginTop = 0;
  int marginLeft = 0;
  int marginRight = 0;
  int marginBottom = 0;
  List<TextLine> lines = [];
  Text({this.id = 0, required this.name, required this.lines, this.marginTop = 0, this.marginLeft = 0, this.marginRight = 0, this.marginBottom = 0});

  @override
  factory Text.fromJson(Map<String, dynamic> json) {
    return Text(
      id: json['id'],
      name: json['name'],
      marginTop: json['margin_top'],
      marginLeft: json['margin_left'],
      marginRight: json['margin_right'],
      marginBottom: json['margin_bottom'],
      lines: json['text_lines'] != null
              ? List<TextLine>.from(json['text_lines'].map((e) => TextLine.fromJson(e)))
              : [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'margin_top': marginTop,
      'margin_left': marginLeft,
      'margin_right': marginRight,
      'margin_bottom': marginBottom,
      'text_lines': lines.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return name;
  }

  @override
  Widget toWidget() {
    return material.Text(name, style: const material.TextStyle(fontSize: 20, color: material.Colors.white));
  }
}

class TextLine implements Serializable {
  String text;
  int fontHeight;
  String color;
  int textId;

  TextLine({required this.text, required this.fontHeight, required this.color, required this.textId});

  @override
  factory TextLine.fromJson(Map<String, dynamic> json) {
    return TextLine(
      text: json['text'],
      fontHeight: json['font_height'],
      color: json['color'],
      textId: json['text_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'font_height': fontHeight,
      'color': color,
      'text_id': textId,
    };
  }
}