import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final String givenName;
  final String familyName;
  final String username;
  final String password;

  const RegisterEvent(
      this.givenName, this.familyName, this.username, this.password);

  @override
  List<Object> get props => [givenName, familyName, username, password];
}
