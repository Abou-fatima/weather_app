import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecases/clear_cache.dart';
import 'package:weather_app/domain/usecases/get_cached_weather.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:weather_app/domain/usecases/logout.dart';
import 'package:weather_app/presentation/bloc/weather/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetCachedWeather getCachedWeather;
  final ClearCache clearCache;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getCachedWeather,
    required this.clearCache,
  }) : super(WeatherInitial()) {
    on<GetWeatherEvent>(_onGetWeather);
    on<GetCachedWeatherEvent>(_onGetCachedWeather);
    on<ClearCacheEvent>(_onClearCache);
    on<WeatherRefreshEvent>(_onRefresh);
  }

  Future<void> _onGetWeather(
    GetWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    final result =
        await getCurrentWeather(GetCurrentWeatherParams(city: event.city));

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onGetCachedWeather(
    GetCachedWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    final result = await getCachedWeather(NoParams());

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather, fromCache: true)),
    );
  }

  Future<void> _onClearCache(
    ClearCacheEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final result = await clearCache(NoParams());

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (_) => emit(WeatherCacheCleared()),
    );
  }

  Future<void> _onRefresh(
    WeatherRefreshEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final currentState = state;
    if (currentState is WeatherLoaded) {
      add(GetWeatherEvent(city: currentState.weather.city));
    }
  }
}
