class WeatherInfo {
  final String city;
  final double temperature;
  final String description;

  WeatherInfo({required this.city, required this.temperature, required this.description});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      city: json['name'] as String,
      temperature: (json['main']['temp'] as num).toDouble(),
      description: (json['weather'] is List && (json['weather'] as List).isNotEmpty)
          ? (json['weather'] as List).first['description'] as String
          : 'No description available',
    );
  }
}
