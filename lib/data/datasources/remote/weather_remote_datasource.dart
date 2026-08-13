import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/app_constants.dart';
import 'package:weather_app/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather({
    required String city,
    required String apiKey,
  });

  Future<Map<String, dynamic>> getForecast({
    required String city,
    required String apiKey,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<WeatherModel> getCurrentWeather({
    required String city,
    required String apiKey,
  }) async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/weather',
      queryParameters: {'q': city, 'appid': apiKey},
    );
    return WeatherModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<Map<String, dynamic>> getForecast({
    required String city,
    required String apiKey,
  }) async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/forecast',
      queryParameters: {'q': city, 'appid': apiKey},
    );
    return response.data as Map<String, dynamic>;
  }
}
