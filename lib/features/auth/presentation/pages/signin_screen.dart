import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate_app/core/common_components/custom_text_form_field.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/constants/image_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AuthSignIn extends StatefulWidget {
  const AuthSignIn({super.key});

  @override
  _AuthSignInState createState() => _AuthSignInState();
}

class _AuthSignInState extends State<AuthSignIn> {
  static const String keylogin = 'Login';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final sharedPref = await SharedPreferences.getInstance();
    final isLoggedIn = sharedPref.getBool(keylogin) ?? false;
    if (isLoggedIn) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Success')),
            );
            final sharedPref = await SharedPreferences.getInstance();
            await sharedPref.setBool(keylogin, true);
            context.go('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            FirebaseCrashlytics.instance.log("Login failed: ${state.message}");
            FirebaseCrashlytics.instance.crash();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(child: SizedBox()),
                Center(
                  child: SvgPicture.asset(
                    AppAssets.companyIcon,
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextFormField(
                  controller: usernameController,
                  labelText: 'Username',
                  hintText: 'Enter Username',
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 130.0, right: 130),
                  child: ElevatedButton(
                    onPressed: () {
                      final username = usernameController.text;
                      final password = passwordController.text;
                      context
                          .read<AuthBloc>()
                          .add(LoginEvent(username, password));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Sign in',
                        style: getHeebo(
                          FontWeight.w500,
                          14,
                          AppColors.whiteTextColor,
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      context.push('/signin/registration');
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Don’t have an account yet? ',
                        style: getHeebo(FontWeight.w400, 16, const Color(0xff44546F)),
                        children: [
                          TextSpan(
                              text: 'Sign up',
                              style: getHeebo(FontWeight.w400, 16,
                                  const Color(0xff1E2C75))),
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
