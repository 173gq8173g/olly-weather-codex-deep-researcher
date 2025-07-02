import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:olly_weather_codex_deep_researcher/login_screen.dart';
import 'package:olly_weather_codex_deep_researcher/weather_service.dart';
import 'package:geolocator/geolocator.dart';

class FakeWeatherService extends WeatherService {
  @override
  Future<WeatherInfo> fetchWeather(double lat, double lon) async {
    return WeatherInfo(
      city: 'TestCity',
      temperature: 20.0,
      description: 'Sunny',
      icon: '01d',
    );
  }
}

void main() {
  testWidgets('login flow shows weather', (WidgetTester tester) async {
    final pos = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
      floor: null,
      isMocked: false,
    );
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen(service: FakeWeatherService(), position: pos)),
    );

    await tester.enterText(find.byType(TextField).at(0), 'user');
    await tester.enterText(find.byType(TextField).at(1), 'pass');
    await tester.tap(find.text('Login'));
    await tester.pump(); // start navigation
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('TestCity'), findsOneWidget);
    expect(find.byKey(const Key('temp')), findsOneWidget);
  });
}
