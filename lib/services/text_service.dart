
import 'package:magicsquare/models/api/text.dart';

import 'base_service.dart';

class TextService extends BaseService {
  static String endpoint = 'texts';

  static Future<Text> createText(Text text) async {
    return Text.fromJson(await BaseService.postData(endpoint, text));
  }

  static Future<List<Text>> getTexts() async {
    var response = await BaseService.getData(endpoint);
    return (response as List).map((e) => Text.fromJson(e)).toList();
  }

  static Future updateText(int i, Text text) async {
    var response = await BaseService.putData('$endpoint/$i', text);
    return Text.fromJson(response);
  }

  static Future<Text> getText(int id) {
    return BaseService.getData('$endpoint/$id').then((response) => Text.fromJson(response));
  }

  static Future deleteText(int id) {
    return BaseService.deleteData('$endpoint/$id');
  }
}
