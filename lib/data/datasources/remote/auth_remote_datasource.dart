import 'package:dio/dio.dart';
import 'package:weather_app/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(Map<String, dynamic> body);
  Future<UserModel> register(Map<String, dynamic> body);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(Map<String, dynamic> body) async {
    final response = await dio.post('https://reqres.in/api/login', data: body);
    final data = response.data as Map<String, dynamic>;
    return UserModel(
      id: data['id']?.toString() ?? '',
      email: body['email'] ?? '',
      username: body['username'] ?? '',
      token: data['token'],
    );
  }

  @override
  Future<UserModel> register(Map<String, dynamic> body) async {
    final response =
        await dio.post('https://reqres.in/api/register', data: body);
    final data = response.data as Map<String, dynamic>;
    return UserModel(
      id: data['id']?.toString() ?? '',
      email: body['email'] ?? '',
      username: body['username'] ?? '',
      token: data['token'],
    );
  }

  @override
  Future<void> logout() async {
    await dio.post('https://reqres.in/api/logout');
  }
}
