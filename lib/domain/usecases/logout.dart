import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  Future<Either<Failure, void>> call(NoParams params) {
    return repository.logout();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
