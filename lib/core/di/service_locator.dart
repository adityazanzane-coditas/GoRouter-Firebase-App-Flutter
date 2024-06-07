import 'package:get_it/get_it.dart';
import 'package:navigate_app/features/auth/data/datasource/user_repository_impl.dart';
import 'package:navigate_app/features/auth/data/firebase_auth_impl/firebase_auth_services.dart';
import 'package:navigate_app/features/auth/data/repositories/auth_repository.dart';
import 'package:navigate_app/features/auth/domain/usecases/auth_usecases.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:navigate_app/features/dashboard/data/datasource/firebase_datasource.dart';
import 'package:navigate_app/features/dashboard/data/respositories/dashboard_repository_impl.dart';
import 'package:navigate_app/features/dashboard/domain/respositories/dashboard_repository.dart';
import 'package:navigate_app/features/dashboard/domain/usecases/get_authors_usecase.dart';
import 'package:navigate_app/features/dashboard/domain/usecases/get_books_usecase.dart';
import 'package:navigate_app/features/dashboard/presentation/bloc/navigation_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<AuthRepository>(
    () => UserRepositoryImpl(getIt<FirebaseAuthService>()),
  );
  getIt.registerLazySingleton<RegisterUserUseCase>(
    () => RegisterUserUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LoginUserUseCase>(
    () => LoginUserUseCase(getIt<AuthRepository>()),
  );
  getIt.registerFactory(
    () => AuthBloc(
      getIt<RegisterUserUseCase>(),
      getIt<LoginUserUseCase>(),
    ),
  );
  getIt.registerLazySingleton<FirebaseDatasource>(() => FirebaseDatasource());
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(getIt<FirebaseDatasource>()),
  );
  getIt.registerLazySingleton<GetAuthorsUseCase>(
    () => GetAuthorsUseCase(getIt<DashboardRepository>()),
  );
  getIt.registerLazySingleton<GetBooksUseCase>(
    () => GetBooksUseCase(getIt<DashboardRepository>()),
  );
  getIt.registerFactory(
    () => NavigationBloc(),
  );
}