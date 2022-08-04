import 'dart:developer';

import 'package:zartek_test/app_models/dish_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Dish>?> getDish() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');

    var respone = await client.get(uri);

    if (respone.statusCode == 200) {
      log("ok");
      var json = respone.body;
      return dishFromJson(json).toList();
    }
  }
}
