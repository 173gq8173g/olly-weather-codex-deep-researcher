# Flutter Weather App

This Flutter project provides a simple login screen that navigates to a weather screen showing the current weather for the user's location. The location is obtained using the `geolocator` package and weather data is fetched from the OpenWeatherMap API.

## Getting Started

1. Ensure you have Flutter installed and web support enabled.
2. Clone the repository and add your OpenWeatherMap API key in `lib/services/weather_service.dart` by replacing `YOUR_API_KEY`.
3. Run `flutter pub get` to install dependencies.
4. Run the app:
   - Mobile: `flutter run`
   - Web: `flutter run -d chrome`

## Running Tests

Execute `flutter test` to run unit and widget tests. Tests use a fake weather service so no network access is required.

## Notes

- Any non-empty username and password will allow login.
- If location permission is denied, the app falls back to London coordinates.
