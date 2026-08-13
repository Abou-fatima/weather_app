import 'package:hive/hive.dart';
import 'package:weather_app/core/constants/app_constants.dart';
import 'package:weather_app/data/models/user_model.dart';
import 'package:weather_app/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(WeatherModel weather);
  Future<WeatherModel?> getCachedWeather();
  Future<void> clearCache();
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearUser();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  late Box<dynamic> _weatherBox;
  late Box<dynamic> _userBox;

  WeatherLocalDataSourceImpl() {
    _initBoxes();
  }

  Future<void> _initBoxes() async {
    _weatherBox = await Hive.openBox<dynamic>(AppConstants.hiveBoxName);
    _userBox = await Hive.openBox<dynamic>(AppConstants.hiveUserBox);
  }

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    await _weatherBox.put('current_weather', weather);
    await _weatherBox.put('timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<WeatherModel?> getCachedWeather() async {
    try {
      final weather = _weatherBox.get('current_weather') as WeatherModel?;
      final timestamp = _weatherBox.get('timestamp') as int?;

      if (weather == null || timestamp == null) return null;

      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > AppConstants.cacheDuration.inMilliseconds) {
        await _weatherBox.delete('current_weather');
        await _weatherBox.delete('timestamp');
        return null;
      }

      return weather;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    await _weatherBox.clear();
  }

  Future<void> cacheUser(UserModel user) async {
    await _userBox.put('user', user);
  }

  Future<UserModel?> getCachedUser() async {
    final user = _userBox.get('user');
    return user is UserModel ? user : null;
  }

  Future<void> clearUser() async {
    await _userBox.delete('user');
  }
}
