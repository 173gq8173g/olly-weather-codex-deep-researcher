import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherInfo {
  final String city;
  final double temperature;
  final String description;
  final String icon;

  WeatherInfo({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      city: json['name'] as String,
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] as String,
      icon: json['weather'][0]['icon'] as String,
    );
  }
}

class WeatherService {
  static const String apiKey = 'YOUR_API_KEY_HERE';
  final http.Client _client;

  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  Future<WeatherInfo> fetchWeather(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey');
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return WeatherInfo.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather');
    }
  }
}
