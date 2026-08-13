import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final String icon;
  final String city;
  final int timestamp;

  const Weather({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
    required this.city,
    required this.timestamp,
  });

  String get tempString => '${temp.round()}°C';
  String get feelsLikeString => '${feelsLike.round()}°C';
  String get humidityString => '$humidity%';
  String get windSpeedString => '${windSpeed.round()} km/h';
  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        humidity,
        windSpeed,
        description,
        icon,
        city,
        timestamp,
      ];
}