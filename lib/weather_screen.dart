import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, this.service, this.position});

  final WeatherService? service;
  final Position? position;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherInfo? _weather;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      Position position = widget.position ??
          await Geolocator.getCurrentPosition().catchError((_) => Position(
                longitude: -0.1278,
                latitude: 51.5074,
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
              ));
      final service = widget.service ?? WeatherService();
      final data = await service.fetchWeather(position.latitude, position.longitude);
      setState(() {
        _weather = data;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load weather';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Center(
        child: SizedBox(
          width: width > 600 ? 500 : double.infinity,
          child: _error != null
              ? Text(_error!, key: const Key('error'))
              : _weather == null
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_weather!.city,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 8),
                        Text('${_weather!.temperature.toStringAsFixed(1)} °C',
                            style: Theme.of(context).textTheme.headlineMedium,
                            key: const Key('temp')),
                        const SizedBox(height: 8),
                        Text(_weather!.description,
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
        ),
      ),
    );
  }
}
