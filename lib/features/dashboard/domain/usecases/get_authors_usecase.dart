import 'package:navigate_app/features/dashboard/domain/entities/author_entity.dart';
import 'package:navigate_app/features/dashboard/domain/respositories/dashboard_repository.dart';

class GetAuthorsUseCase {
  final DashboardRepository repository;

  GetAuthorsUseCase(this.repository);

  Stream<List<AuthorEntity>> call() {
    return repository.getAuthors();
  }
}