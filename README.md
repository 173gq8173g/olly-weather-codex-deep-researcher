# Flutter Weather App – Interview Challenge

This project is a minimal Flutter application featuring a dummy login screen and a weather screen that fetches the current weather for the user's location using the OpenWeatherMap API.

## Getting Started

1. **Flutter SDK**: Ensure Flutter (3.x) is installed and on your `PATH`.
2. **Dependencies**: Run `flutter pub get` to install packages.
3. **API Key**: Obtain an OpenWeatherMap API key and replace the `apiKey` constant in `lib/weather_service.dart`.

### Running

- **Mobile/Web**: `flutter run` (add `-d chrome` to run on the web).

### Testing

Run `flutter test` to execute the widget test verifying the login flow and weather display.

## Project Structure

- `lib/main.dart` – entry point configuring routes.
- `lib/login_screen.dart` – simple login form.
- `lib/weather_screen.dart` – fetches and displays weather data.
- `lib/weather_service.dart` – handles HTTP calls and parsing.
- `test/widget_test.dart` – widget test with a fake weather service.

## Notes

- Any non-empty credentials succeed for login.
- If location access fails (or on web tests), a default location (London) is used.
- The UI is intentionally simple and responsive on both mobile and web.
