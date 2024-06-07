
import 'package:mosaico/networking/coap/base_service.dart';

class WidgetService
{
  static Future installWidget(int id) async {
    return BaseService.post('/installed_widgets', '{"id": $id}');
  }



}