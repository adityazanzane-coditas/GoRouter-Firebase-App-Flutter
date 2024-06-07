import 'package:navigate_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> registerUser(UserEntity userEntity);
  Future<void> loginUser(UserEntity userEntity);
}
