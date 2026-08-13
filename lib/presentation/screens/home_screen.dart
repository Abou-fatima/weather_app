import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:weather_app/presentation/bloc/auth/auth_event.dart';
import 'package:weather_app/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather/weather_state.dart';
import 'package:weather_app/presentation/widgets/weather_card.dart';
import 'package:weather_app/presentation/widgets/loading_widget.dart';
import 'package:weather_app/presentation/widgets/error_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _city = 'Paris';

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  void _loadWeather() {
    context.read<WeatherBloc>().add(GetWeatherEvent(city: _city));
  }

  void _logout() {
    context.read<AuthBloc>().add(LogoutEvent());
    context.go('/login');
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter city name...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _city = value.trim();
                        });
                        _loadWeather();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadWeather,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Weather Content
            Expanded(
              child: BlocConsumer<WeatherBloc, WeatherState>(
                listener: (context, state) {
                  if (state is WeatherError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const LoadingWidget();
                  } else if (state is WeatherLoaded) {
                    return WeatherCard(
                      weather: state.weather,
                      fromCache: state.fromCache,
                    );
                  } else if (state is WeatherError) {
                    return CustomErrorWidget(
                      message: state.message,
                      onRetry: _loadWeather,
                    );
                  } else {
                    return const Center(
                      child: Text('Search for a city to see the weather'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}