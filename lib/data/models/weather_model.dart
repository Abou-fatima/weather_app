import 'package:weather_app/domain/entities/weather.dart';

class WeatherModel {
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final String icon;
  final String city;
  final int timestamp;

  WeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
    required this.city,
    required this.timestamp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final weather = json['weather']?[0] ?? {};
    final wind = json['wind'] ?? {};

    return WeatherModel(
      temp: (main['temp'] ?? 0.0) - 273.15,
      feelsLike: (main['feels_like'] ?? 0.0) - 273.15,
      humidity: main['humidity'] ?? 0,
      windSpeed: wind['speed'] ?? 0.0,
      description: weather['description'] ?? 'Unknown',
      icon: weather['icon'] ?? '01d',
      city: json['name'] ?? 'Unknown',
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  Weather toEntity() {
    return Weather(
      temp: temp,
      feelsLike: feelsLike,
      humidity: humidity,
      windSpeed: windSpeed,
      description: description,
      icon: icon,
      city: city,
      timestamp: timestamp,
    );
  }
}
