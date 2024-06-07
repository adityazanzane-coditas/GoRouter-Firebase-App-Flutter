import 'package:navigate_app/features/dashboard/domain/entities/author_entity.dart';
import 'package:navigate_app/features/dashboard/domain/entities/book_entity.dart';

abstract class DashboardRepository {
  Stream<List<AuthorEntity>> getAuthors();
  Stream<List<BookEntity>> getBooks();
}