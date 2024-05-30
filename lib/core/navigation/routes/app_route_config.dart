import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/features/auth/presentation/pages/registration_screen.dart';
import 'package:navigate_app/features/auth/presentation/pages/signin_screen.dart';
import 'package:navigate_app/features/dashboard/models/author_model.dart';
import 'package:navigate_app/features/dashboard/models/book_model.dart';
import 'package:navigate_app/features/dashboard/presentation/bloc/navigation_bloc.dart';
import 'package:navigate_app/features/dashboard/presentation/bloc/navigation_event.dart';
import 'package:navigate_app/features/dashboard/presentation/bloc/navigation_state.dart';
import 'package:navigate_app/features/dashboard/presentation/pages/author_details_screen.dart';
import 'package:navigate_app/features/dashboard/presentation/pages/author_screen.dart';
import 'package:navigate_app/features/dashboard/presentation/pages/books_details_screen.dart';
import 'package:navigate_app/features/dashboard/presentation/pages/books_screen.dart';
import 'package:navigate_app/features/dashboard/presentation/pages/home_screen.dart';
import 'package:navigate_app/features/dashboard/presentation/pages/setting_screen.dart';
import 'package:navigate_app/features/onboarding/presentation/pages/onboarding_screen_one.dart';
import 'package:navigate_app/features/onboarding/presentation/pages/onboarding_screen_three.dart';
import 'package:navigate_app/features/onboarding/presentation/pages/onboarding_screen_two.dart';
import 'package:navigate_app/features/splash/presentation/page/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding1',
      builder: (context, state) => const OnBoardingScreenOne(),
    ),
    GoRoute(
      path: '/onboarding2',
      builder: (context, state) => const OnBoardingScreenTwo(),
    ),
    GoRoute(
      path: '/onboarding3',
      builder: (context, state) => const OnBoardingScreenThree(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const AuthSignIn(),
      routes: [
        GoRoute(
          path: 'registration',
          builder: (context, state) => const RegistrationScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/author/:name',
      builder: (context, state) {
        final author = state.extra as Author;
        return AuthorDetailsScreen(
          authorName: author.name,
          authorDescription: author.description,
        );
      },
    ),
    GoRoute(
      path: '/books/:name',
      builder: (context, state) {
        final book = state.extra as Book;
        return BookDetailsScreen(
          bookName: book.name,
          bookDescription: book.description,
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, navState) {
            return Scaffold(
              backgroundColor: backgroundColor,
              body: IndexedStack(
                index: navState.index,
                children: const [
                  HomeScreen(),
                  AuthorScreen(),
                  BooksScreen(),
                  SettingsScreen(),
                ],
              ),
              bottomNavigationBar: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: navState.index,
                  onTap: (index) {
                    context
                        .read<NavigationBloc>()
                        .add(NavigationItemTapped(index));
                  },
                  selectedItemColor: Colors.black,
                  unselectedItemColor: const Color(0xff878787),
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        colorFilter: const ColorFilter.mode(
                            Color(0xff626F86), BlendMode.srcIn),
                      ),
                      label: AppLocalizations.of(context)!.home,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/author.svg',
                        colorFilter: const ColorFilter.mode(
                            Color(0xff626F86), BlendMode.srcIn),
                      ),
                      label: AppLocalizations.of(context)!.authors,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/books.svg',
                        colorFilter: const ColorFilter.mode(
                            Color(0xff626F86), BlendMode.srcIn),
                      ),
                      label: AppLocalizations.of(context)!.books,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/setting.svg',
                        colorFilter: const ColorFilter.mode(
                            Color(0xff626F86), BlendMode.srcIn),
                      ),
                      label: AppLocalizations.of(context)!.settingScreen,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
