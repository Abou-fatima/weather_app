import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecases/login.dart';
import 'package:weather_app/domain/usecases/register.dart';
import 'package:weather_app/domain/usecases/logout.dart';
import 'package:weather_app/presentation/bloc/auth/auth_event.dart';
import 'package:weather_app/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final Logout logout;

  AuthBloc({
    required this.login,
    required this.register,
    required this.logout,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<AuthResetEvent>(_onReset);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await login(LoginParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await register(RegisterParams(
      email: event.email,
      username: event.username,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await logout(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Vérifier si l'utilisateur est en cache
    // Pour simplifier, on simule une vérification
    emit(AuthUnauthenticated());
  }

  void _onReset(AuthResetEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}