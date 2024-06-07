import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String name;
  final String description;

  const BookEntity({
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [name, description];
}