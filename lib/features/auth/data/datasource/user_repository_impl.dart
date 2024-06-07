import 'package:navigate_app/features/auth/data/repositories/auth_repository.dart';
import 'package:navigate_app/features/auth/domain/entities/user_entity.dart';
import 'package:navigate_app/features/auth/data/firebase_auth_impl/firebase_auth_services.dart';

class UserRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  UserRepositoryImpl(this._firebaseAuthService);

  @override
  Future<void> registerUser(UserEntity userEntity) async {
    await _firebaseAuthService.signUpWithEmailAndPassword(
        userEntity.email, userEntity.password);
  }

  @override
  Future<void> loginUser(UserEntity userEntity) async {
    await _firebaseAuthService.signInWithEmailAndPassword(
        userEntity.email, userEntity.password);
  }
}