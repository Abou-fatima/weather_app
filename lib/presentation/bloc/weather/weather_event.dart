import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  final String city;

  const GetWeatherEvent({required this.city});

  @override
  List<Object?> get props => [city];
}

class GetCachedWeatherEvent extends WeatherEvent {}

class ClearCacheEvent extends WeatherEvent {}

class WeatherRefreshEvent extends WeatherEvent {}