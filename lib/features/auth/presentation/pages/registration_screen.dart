import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate_app/core/common_components/custom_text_form_field.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:navigate_app/features/auth/presentation/bloc/auth_state.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: false,
        titleTextStyle: getHeebo(
          FontWeight.w500,
          16,
          AppColors.authTextColor,
        ),
        elevation: 0.5,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/signin');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 34.0, right: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                CustomTextFormField(
                  controller: firstNameController,
                  labelText: 'First Name',
                  hintText: 'Enter First Name',
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: lastNameController,
                  labelText: 'Last Name',
                  hintText: 'Enter Last Name',
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Enter Email',
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
                      final email = emailController.text;
                      final password = passwordController.text;

                      context.read<AuthBloc>().add(
                            RegisterEvent(email, password),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Sign up',
                        style: getHeebo(
                          FontWeight.w500,
                          14,
                         AppColors.whiteTextColor,
                        )),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
