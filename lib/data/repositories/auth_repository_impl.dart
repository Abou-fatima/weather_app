import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/data/datasources/local/weather_local_datasource.dart';
import 'package:weather_app/data/datasources/remote/auth_remote_datasource.dart';
import 'package:weather_app/data/models/user_model.dart';
import 'package:weather_app/domain/entities/user.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel =
          await remoteDataSource.login({'email': email, 'password': password});
      await localDataSource.cacheUser(userModel);
      return Right(User(
        id: userModel.id,
        email: userModel.email,
        username: userModel.username,
        token: userModel.token,
      ));
    } catch (e) {
      return Left(AuthFailure('Échec de connexion'));
    }
  }

  @override
  Future<Either<Failure, User>> register(
      String email, String username, String password) async {
    try {
      final userModel = await remoteDataSource.register({
        'email': email,
        'username': username,
        'password': password,
      });
      await localDataSource.cacheUser(userModel);
      return Right(User(
        id: userModel.id,
        email: userModel.email,
        username: userModel.username,
        token: userModel.token,
      ));
    } catch (e) {
      return Left(AuthFailure('Échec d’inscription'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure('Échec de déconnexion'));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getCachedUser();
      if (userModel == null) {
        return Left(AuthFailure('Aucun utilisateur connecté'));
      }
      return Right(User(
        id: userModel.id,
        email: userModel.email,
        username: userModel.username,
        token: userModel.token,
      ));
    } catch (e) {
      return Left(AuthFailure('Erreur utilisateur'));
    }
  }
}
