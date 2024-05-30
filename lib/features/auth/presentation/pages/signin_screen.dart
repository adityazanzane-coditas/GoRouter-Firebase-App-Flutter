import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate_app/core/common_components/custom_text_form_field.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/core/theme/font.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:navigate_app/features/splash/presentation/page/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSignIn extends StatelessWidget {
  const AuthSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Success')),
            );
            context.go('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
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
                    'assets/icons/company_icon.svg',
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
                    onPressed: () async {
                      final username = usernameController.text;
                      final password = passwordController.text;

                      var sharedPref = await SharedPreferences.getInstance();
                      sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
                      context.read<AuthBloc>().add(
                            LoginEvent(username, password),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Sign',
                        style: getHeebo(FontWeight.w500, 14, whiteTextColor)),
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
                        style: getHeebo(
                            FontWeight.w400, 16, const Color(0xff44546F)),
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
