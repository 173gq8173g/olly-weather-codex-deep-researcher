import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/models/weather_info.dart';

void main() {
  test('WeatherInfo fromJson parses correctly', () {
    const jsonStr = '{"name":"London","main":{"temp":10},"weather":[{"description":"Cloudy"}] }';
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    final info = WeatherInfo.fromJson(json);
    expect(info.city, 'London');
    expect(info.temperature, 10);
    expect(info.description, 'Cloudy');
  });
}
