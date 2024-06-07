import 'package:equatable/equatable.dart';

class AuthorEntity extends Equatable {
  final String name;
  final String description;

  const AuthorEntity({
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [name, description];
}