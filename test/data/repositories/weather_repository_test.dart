import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/data/datasources/local/weather_local_datasource.dart';
import 'package:weather_app/data/datasources/remote/weather_remote_datasource.dart';
import 'package:weather_app/data/models/user_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';

class FakeWeatherRemoteDataSource implements WeatherRemoteDataSource {
  WeatherModel? nextWeather;
  bool shouldThrow = false;

  @override
  Future<WeatherModel> getCurrentWeather({
    required String city,
    required String apiKey,
  }) async {
    if (shouldThrow) {
      throw ServerException('API Error');
    }
    return nextWeather ??
        WeatherModel(
          temp: 20,
          feelsLike: 18,
          humidity: 65,
          windSpeed: 12,
          description: 'Clear sky',
          icon: '01d',
          city: city,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        );
  }

  @override
  Future<Map<String, dynamic>> getForecast({
    required String city,
    required String apiKey,
  }) async {
    return {'city': city};
  }
}

class FakeWeatherLocalDataSource implements WeatherLocalDataSource {
  WeatherModel? cachedWeather;
  bool shouldThrowOnClear = false;

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    cachedWeather = weather;
  }

  @override
  Future<WeatherModel?> getCachedWeather() async => cachedWeather;

  @override
  Future<void> clearCache() async {
    if (shouldThrowOnClear) {
      throw CacheException('Clear failed');
    }
    cachedWeather = null;
  }

  @override
  Future<void> cacheUser(UserModel user) async {}

  @override
  Future<UserModel?> getCachedUser() async => null;

  @override
  Future<void> clearUser() async {}
}

class FakeNetworkInfo implements NetworkInfo {
  bool connected = true;

  @override
  Future<bool> get isConnected async => connected;
}

void main() {
  late WeatherRepositoryImpl repository;
  late FakeWeatherRemoteDataSource fakeRemoteDataSource;
  late FakeWeatherLocalDataSource fakeLocalDataSource;
  late FakeNetworkInfo fakeNetworkInfo;

  const tCity = 'Paris';
  final tWeatherModel = WeatherModel(
    temp: 20.0,
    feelsLike: 18.0,
    humidity: 65,
    windSpeed: 12.0,
    description: 'Clear sky',
    icon: '01d',
    city: 'Paris',
    timestamp: DateTime.now().millisecondsSinceEpoch,
  );

  setUp(() {
    fakeRemoteDataSource = FakeWeatherRemoteDataSource();
    fakeLocalDataSource = FakeWeatherLocalDataSource();
    fakeNetworkInfo = FakeNetworkInfo();
    repository = WeatherRepositoryImpl(
      remoteDataSource: fakeRemoteDataSource,
      localDataSource: fakeLocalDataSource,
      networkInfo: fakeNetworkInfo,
    );
    fakeRemoteDataSource.nextWeather = tWeatherModel;
  });

  group('getCurrentWeather', () {
    test('should return weather when connected and API call succeeds',
        () async {
      fakeNetworkInfo.connected = true;
      final result = await repository.getCurrentWeather(tCity);

      expect(result, Right(tWeatherModel.toEntity()));
      expect(fakeLocalDataSource.cachedWeather, tWeatherModel);
    });

    test('should return cached weather when no connection and cache exists',
        () async {
      fakeNetworkInfo.connected = false;
      fakeLocalDataSource.cachedWeather = tWeatherModel;

      final result = await repository.getCurrentWeather(tCity);

      expect(result, Right(tWeatherModel.toEntity()));
    });

    test('should return NetworkFailure when no connection and no cache',
        () async {
      fakeNetworkInfo.connected = false;
      fakeLocalDataSource.cachedWeather = null;

      final result = await repository.getCurrentWeather(tCity);

      expect(result, Left(NetworkFailure('Pas de connexion et pas de cache')));
    });

    test('should return ServerFailure when API returns an error', () async {
      fakeNetworkInfo.connected = true;
      fakeRemoteDataSource.shouldThrow = true;

      final result = await repository.getCurrentWeather(tCity);

      expect(result, Left(ServerFailure('API Error')));
    });
  });

  group('getCachedWeather', () {
    test('should return cached weather when cache exists and not expired',
        () async {
      fakeLocalDataSource.cachedWeather = tWeatherModel;

      final result = await repository.getCachedWeather();

      expect(result, Right(tWeatherModel.toEntity()));
    });

    test('should return CacheFailure when no cached weather', () async {
      fakeLocalDataSource.cachedWeather = null;

      final result = await repository.getCachedWeather();

      expect(result, Left(CacheFailure('Aucune météo en cache')));
    });
  });

  group('clearCache', () {
    test('should clear cache successfully', () async {
      fakeLocalDataSource.cachedWeather = tWeatherModel;

      final result = await repository.clearCache();

      expect(result, const Right(true));
      expect(fakeLocalDataSource.cachedWeather, isNull);
    });

    test('should return CacheFailure when clearing fails', () async {
      fakeLocalDataSource.shouldThrowOnClear = true;

      final result = await repository.clearCache();

      expect(result, Left(CacheFailure('Clear failed')));
    });
  });
}
