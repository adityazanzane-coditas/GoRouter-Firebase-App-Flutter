import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = 'Login';

  @override
  void initState() {
    super.initState();
    _navigateBasedOnLoginStatus();
  }

  Future<void> _navigateBasedOnLoginStatus() async {
    final sharedPref = await SharedPreferences.getInstance();
    final isLoggedIN = sharedPref.getBool(KEYLOGIN) ?? false;

    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIN) {
      context.go('/home');
    } else {
      context.go('/onboarding1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: SvgPicture.asset('assets/icons/company_icon.svg')),
    );
  }
}
