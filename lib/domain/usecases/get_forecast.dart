import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class GetForecast {
  final WeatherRepository repository;

  GetForecast(this.repository);

  Future<Either<Failure, Weather>> call(GetForecastParams params) {
    return repository.getCurrentWeather(params.city);
  }
}

class GetForecastParams extends Equatable {
  final String city;

  const GetForecastParams({required this.city});

  @override
  List<Object?> get props => [city];
}
