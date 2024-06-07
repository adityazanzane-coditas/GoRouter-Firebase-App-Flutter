import 'package:navigate_app/features/dashboard/domain/entities/author_entity.dart';

class AuthorModel extends AuthorEntity {
  const AuthorModel({
    required super.name,
    required super.description,
  });

  factory AuthorModel.fromMap(Map<String, dynamic> data) {
    return AuthorModel(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}