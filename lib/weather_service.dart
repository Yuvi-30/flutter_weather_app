import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService{
  final String apikey = '5c1296bad970de5c2c950702d87ec0e5';
  Future<Map<String, dynamic>> fetchWeather(String city) async{
    final response = await http.get(
      Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=5c1296bad970de5c2c950702d87ec0e5&units=metric'),

    );

    if (response.statusCode == 200){
      print(city);
      print(response.body);
      return json.decode(response.body);


    }
    else{
      throw Exception('failed to load weather data');
    }
  }
}