import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate_app/core/common_components/custom_button.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';

class OnBoardingScreenThree extends StatelessWidget {
  const OnBoardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(flex: 1, child: SizedBox()),
            const SizedBox(height: 26),
            Expanded(
              flex: 8,
              child: Container(
                color: const Color(0xffD9D9D9),
                width: double.infinity,
                child: const Center(child: Text('Image 3')),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Back',
                  onPressed: () {
                    context.go('/onboarding2');
                  },
                  backgroundColor: AppColors.buttonColor,
                  horizontalPadding: 46,
                  verticalPadding: 15,
                  borderRadius: 12,
                  textStyle: getHeebo(FontWeight.w700, 16, Colors.white),
                ),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    context.go('/signin');
                  },
                  backgroundColor: AppColors.buttonColor,
                  horizontalPadding: 46,
                  verticalPadding: 15,
                  borderRadius: 12,
                  textStyle: getHeebo(FontWeight.w700, 16, Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
