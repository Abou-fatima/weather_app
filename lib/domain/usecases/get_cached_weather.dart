import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/logout.dart';

class GetCachedWeather {
  final WeatherRepository repository;

  GetCachedWeather(this.repository);

  Future<Either<Failure, Weather>> call(NoParams params) {
    return repository.getCachedWeather();
  }
}
