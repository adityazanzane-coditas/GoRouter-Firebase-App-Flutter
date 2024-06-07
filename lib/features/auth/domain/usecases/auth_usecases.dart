import 'package:navigate_app/features/auth/data/repositories/auth_repository.dart';
import 'package:navigate_app/features/auth/domain/entities/user_entity.dart';

class RegisterUserUseCase {
  final AuthRepository authRepository;

  RegisterUserUseCase(this.authRepository);

  Future<void> call(UserEntity userEntity) {
    return authRepository.registerUser(userEntity);
  }
}

class LoginUserUseCase {
  final AuthRepository authRepository;

  LoginUserUseCase(this.authRepository);

  Future<void> call(UserEntity userEntity) {
    return authRepository.loginUser(userEntity);
  }
}