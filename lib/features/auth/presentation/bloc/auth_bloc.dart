import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigate_app/features/auth/data/user_repository/user_repository.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc(this.userRepository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      if (userRepository.isUserPresent(event.username, event.password)) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('User is not registered. Please register.'));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());

      userRepository.registerUser(
        event.givenName,
        event.familyName,
        event.username,
        event.password,
      );

      emit(AuthAuthenticated());
    });
  }
}
