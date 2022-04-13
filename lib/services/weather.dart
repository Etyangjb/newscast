import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newscast/constants/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherService {
  WeatherService._();

  static var weatherData;

  static queryWeather(Function setter, String city) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var apiKey = Secrets.OPENWEATHER_API_KEY;
    String url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";

    try {
      final response = await http.post(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        var jsonWeatherResponse = json.decode(response.body)['weather'];
        var jsonNameResponse = json.decode(response.body)['name'];
        var jsonMainResponse = json.decode(response.body)['main'];

        print(jsonWeatherResponse);
        print(jsonMainResponse);

        preferences.setString('city', jsonNameResponse);
        preferences.setString('weather', json.encode(jsonWeatherResponse));
        preferences.setString('main', json.encode(jsonMainResponse));
      } else {
        print('Something went wrong');
      }
    } on Exception catch (e) {
      print('CAUGHT ERROR HERE : ' + e.toString());
    }
  }
}
