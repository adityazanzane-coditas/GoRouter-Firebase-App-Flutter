import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/locale_bloc/locale_bloc.dart';
import 'package:navigate_app/core/locale_bloc/locale_state.dart';
import 'package:navigate_app/core/navigation/routes/app_route_config.dart';
import 'package:navigate_app/features/auth/data/user_repository/user_repository.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:navigate_app/features/dashboard/presentation/bloc/navigation_bloc.dart';
import 'package:navigate_app/l10n/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(userRepository),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<LocaleBloc>(
          create: (context) => LocaleBloc(),
        ),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            supportedLocales: L10n.all,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: state.locale,
          );
        },
      ),
    );
  }
}
