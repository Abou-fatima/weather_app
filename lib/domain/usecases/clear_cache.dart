import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/logout.dart';

class ClearCache {
  final WeatherRepository repository;

  ClearCache(this.repository);

  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.clearCache();
  }
}
