import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'weather_screen.dart';
import 'weather_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.service, this.position});

  final WeatherService? service;
  final Position? position;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String? _error;

  void _login() {
    if (_userController.text.isEmpty || _passController.text.isEmpty) {
      setState(() => _error = 'Please enter username and password');
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => WeatherScreen(
                  service: widget.service,
                  position: widget.position,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width > 600 ? 400 : double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _userController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: _login, child: const Text('Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
