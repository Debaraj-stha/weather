import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/model.dart';

class provider with ChangeNotifier {
  String apikey = "6f9c67f8e60d4ab5b5950022231908";
  List<WeatherData> data=[];
  fetchApiData(String q) async {
    data=[];
    String url = "http://api.weatherapi.com/v1/current.json?key=$apikey&q=${q}";
    final response = await http.get(Uri.parse(url));
    final responseValue = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint(responseValue.toString());
        data.add(WeatherData.fromJson(responseValue));
    } else {
      debugPrint(responseValue.toString());
    }
  notifyListeners();
  }
}
