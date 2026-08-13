import 'package:dartz/dartz.dart';
import 'package:weather_app/core/constants/app_constants.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/data/datasources/local/weather_local_datasource.dart';
import 'package:weather_app/data/datasources/remote/weather_remote_datasource.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String city) async {
    try {
      if (await networkInfo.isConnected) {
        final weatherModel = await remoteDataSource.getCurrentWeather(
          city: city,
          apiKey: AppConstants.apiKey,
        );
        await localDataSource.cacheWeather(weatherModel);
        return Right(weatherModel.toEntity());
      } else {
        return await _getCachedWeather();
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Une erreur est survenue'));
    }
  }

  @override
  Future<Either<Failure, Weather>> getCachedWeather() async {
    try {
      final cachedWeather = await localDataSource.getCachedWeather();
      if (cachedWeather != null) {
        return Right(cachedWeather.toEntity());
      } else {
        return Left(CacheFailure('Aucune météo en cache'));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  Future<Either<Failure, Weather>> _getCachedWeather() async {
    try {
      final cachedWeather = await localDataSource.getCachedWeather();
      if (cachedWeather != null) {
        return Right(cachedWeather.toEntity());
      } else {
        return Left(NetworkFailure('Pas de connexion et pas de cache'));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> clearCache() async {
    try {
      await localDataSource.clearCache();
      return const Right(true);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
