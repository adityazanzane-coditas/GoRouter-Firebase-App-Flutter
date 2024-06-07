import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigate_app/features/auth/domain/entities/user_entity.dart';
import 'package:navigate_app/features/auth/domain/usecases/auth_usecases.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUserUseCase registerUserUseCase;
  final LoginUserUseCase loginUserUseCase;

  AuthBloc(
    this.registerUserUseCase,
    this.loginUserUseCase,
  ) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await loginUserUseCase(UserEntity(
          email: event.email,
          password: event.password,
        ));
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await registerUserUseCase(UserEntity(
          email: event.email,
          password: event.password,
        ));
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}