import 'dart:convert';
import 'package:mosaico/networking/coap/base_service.dart';
import '../../models/widget.dart';

class WidgetService {
  static Future<void> installWidget(int id) async {
    final response = await BaseService.post('/installed_widgets', '{"id": $id}');
    // No need to display the message here
  }

  static Future<List<Widget>> getInstalledWidgets() async {
    final response = await BaseService.get('/installed_widgets');
    final List<dynamic> jsonData = response['data'];
    return jsonData.map((e) => Widget.fromJson(e)).toList();
  }
}
