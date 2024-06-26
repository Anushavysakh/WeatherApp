import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = '01835ff76e49bc30b5f80575c590fa66';


  getCurrentCity(Position? position,String? code) async {
    print("&&&&&&&&&&&&&7");
    final url =
        '$baseUrl?lat=${position?.latitude}&lon=${position?.longitude}&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //  print(response.body);
      var data = jsonDecode(response.body);
      print("**********************");
      //   print(data);
      print("**********************");
      return WeatherModel.fromJson(data);
    } else {
      log("Error");
      throw Exception('Failed to load weather data');
    }
  }
}
