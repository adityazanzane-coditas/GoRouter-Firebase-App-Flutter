import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/constants/image_constants.dart';
import 'package:navigate_app/features/auth/presentation/pages/registration_screen.dart';
import 'package:navigate_app/features/auth/presentation/pages/signin_screen.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) async {
    final sharedPref = await SharedPreferences.getInstance();
    final isLoggedIN = sharedPref.getBool('Login') ?? false;

    if (isLoggedIN) {
      if (state.uri.toString() == '/' ||
          state.uri.toString().startsWith('/signin')) {
        return '/home';
      }
    } else {
      if (state.uri.toString() != '/' &&
          !state.uri.toString().startsWith('/signin')) {
        return '/signin';
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
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
        final authorData = state.extra as Map<String, dynamic>;
        return AuthorDetailsScreen(authorData: authorData);
      },
    ),
    GoRoute(
      path: '/book/:name',
      builder: (context, state) {
        final bookData = state.extra as Map<String, dynamic>;
        return BookDetailsScreen(bookData: bookData);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, navState) {
            return Scaffold(
              backgroundColor: AppColors.blackTextColor,
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
                  backgroundColor: AppColors.whiteTextColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: navState.index,
                  onTap: (index) {
                    context
                        .read<NavigationBloc>()
                        .add(NavigationItemTapped(index));
                  },
                  selectedItemColor: AppColors.blackTextColor,
                  unselectedItemColor: Color(int.parse('0xff878787')),
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppAssets.homeIcon,
                        colorFilter: const ColorFilter.mode(
                            Color(0xff626F86), BlendMode.srcIn),
                      ),
                      label: AppLocalizations.of(context)!.home,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppAssets.authorIcon,
                        colorFilter: const ColorFilter.mode(
                            Color(0xff626F86), BlendMode.srcIn),
                      ),
                      label: AppLocalizations.of(context)!.authors,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppAssets.booksIcon,
                        colorFilter: const ColorFilter.mode(
                            Color(0xff626F86), BlendMode.srcIn),
                      ),
                      label: AppLocalizations.of(context)!.books,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppAssets.settingIcon,
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
