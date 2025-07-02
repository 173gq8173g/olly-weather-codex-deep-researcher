import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../models/weather_info.dart';

class WeatherService {
  static WeatherService? serviceOverride;
  static const String apiKey = 'YOUR_API_KEY'; // Insert API key here

  factory WeatherService() {
    return serviceOverride ?? WeatherService._();
  }

  WeatherService._();

  Future<WeatherInfo> fetchCurrentLocationWeather() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (_) {
      // default to London coordinates if location fails
      position = Position(
        longitude: -0.1276,
        latitude: 51.5074,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      );
    }

    final uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$apiKey',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return WeatherInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load weather. HTTP status code: ${response.statusCode}. Response body: ${response.body}');
    }
  }
}
