import 'package:flutter/material.dart';
import 'services/weather_service.dart';
import 'models/weather_info.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _loading = true;
  WeatherInfo? _info;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final service = WeatherService();
      final info = await service.fetchCurrentLocationWeather();
      setState(() {
        _info = info;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_loading) {
      child = const CircularProgressIndicator();
    } else if (_error != null) {
      child = Text(_error!);
    } else if (_info != null) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_info!.city, style: Theme.of(context).textTheme.headlineSmall),
          Text('${_info!.temperature % 1 == 0 ? _info!.temperature.toInt() : _info!.temperature}°C',
              style: Theme.of(context).textTheme.headlineMedium),
          Text(_info!.description),
        ],
      );
    } else {
      child = const Text('No data');
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
