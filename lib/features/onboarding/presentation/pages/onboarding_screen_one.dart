import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate_app/core/common_components/custom_button.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';

class OnBoardingScreenOne extends StatelessWidget {
  const OnBoardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 282.0),
              child: CustomButton(
                text: 'Skip',
                onPressed: () {
                  context.go('/signin');
                },
                backgroundColor: AppColors.buttonColor,
                horizontalPadding: 32,
                verticalPadding: 0,
                borderRadius: 16,
                textStyle: getHeebo(FontWeight.w700, 14, Colors.white),
              ),
            ),
            const SizedBox(height: 62),
            Expanded(
              child: Container(
                color: const Color(0xffD9D9D9),
                width: double.infinity,
                child: const Center(child: Text('Image 1')),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: CustomButton(
                text: 'Next',
                onPressed: () {
                  context.go('/onboarding2');
                },
                backgroundColor: AppColors.buttonColor,
                horizontalPadding: 46,
                verticalPadding: 15,
                borderRadius: 12,
                textStyle: getHeebo(FontWeight.w700, 16, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
