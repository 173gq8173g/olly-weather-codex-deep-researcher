import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/login_screen.dart';
import 'package:flutter_weather/weather_screen.dart';
import 'package:flutter_weather/services/weather_service.dart';
import 'package:flutter_weather/models/weather_info.dart';

class FakeWeatherService extends WeatherService {
  @override
  Future<WeatherInfo> fetchCurrentLocationWeather() async {
    return WeatherInfo(city: 'Test City', temperature: 20, description: 'Sunny');
  }
}

void main() {
  testWidgets('login and display weather', (tester) async {
    WeatherService.serviceOverride = FakeWeatherService();
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tester.enterText(find.byType(TextFormField).at(0), 'user');
    await tester.enterText(find.byType(TextFormField).at(1), 'pass');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text('Test City'), findsOneWidget);
    expect(find.text('20°C'), findsOneWidget);
  });
}