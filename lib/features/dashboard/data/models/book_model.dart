import 'package:navigate_app/features/dashboard/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.name,
    required super.description,
  });

  factory BookModel.fromMap(Map<String, dynamic> data) {
    return BookModel(
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