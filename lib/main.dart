import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:navigate_app/core/notifications/firebase_notifications.dart';
import 'package:navigate_app/core/locale_bloc/locale_bloc.dart';
import 'package:navigate_app/core/locale_bloc/locale_state.dart';
import 'package:navigate_app/core/navigation/routes/app_route_config.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:navigate_app/features/dashboard/presentation/bloc/navigation_bloc.dart';
import 'package:navigate_app/l10n/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:navigate_app/core/di/service_locator.dart' as di;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  await FirebaseApi().initLocalNotifications();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.getIt<AuthBloc>(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => di.getIt<NavigationBloc>(),
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
