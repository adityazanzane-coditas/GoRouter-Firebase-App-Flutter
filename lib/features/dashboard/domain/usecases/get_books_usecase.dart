import 'package:navigate_app/features/dashboard/domain/entities/book_entity.dart';
import 'package:navigate_app/features/dashboard/domain/respositories/dashboard_repository.dart';

class GetBooksUseCase {
  final DashboardRepository repository;

  GetBooksUseCase(this.repository);

  Stream<List<BookEntity>> call() {
    return repository.getBooks();
  }
}