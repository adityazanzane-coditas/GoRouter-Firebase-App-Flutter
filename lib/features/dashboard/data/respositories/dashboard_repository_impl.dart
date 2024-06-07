import 'package:navigate_app/features/dashboard/data/datasource/firebase_datasource.dart';
import 'package:navigate_app/features/dashboard/domain/entities/author_entity.dart';
import 'package:navigate_app/features/dashboard/domain/entities/book_entity.dart';
import 'package:navigate_app/features/dashboard/domain/respositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final FirebaseDatasource datasource;

  DashboardRepositoryImpl(this.datasource);

  @override
  Stream<List<AuthorEntity>> getAuthors() {
    return datasource.getAuthors().map((authors) => authors);
  }

  @override
  Stream<List<BookEntity>> getBooks() {
    return datasource.getBooks().map((books) => books);
  }
}