import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate_app/core/common_components/custom_button.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/core/theme/font.dart';

class OnBoardingScreenTwo extends StatelessWidget {
  const OnBoardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                backgroundColor: buttonColor,
                horizontalPadding: 32,
                verticalPadding: 0,
                borderRadius: 12,
                textStyle: getHeebo(FontWeight.w700, 16, Colors.white),
              ),
            ),
            const SizedBox(height: 62),
            Expanded(
              child: Container(
                  color: const Color(0xffD9D9D9),
                  width: double.infinity,
                  child: const Center(child: Text('Image 2'))),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Back',
                  onPressed: () {
                    context.go('/onboarding1');
                  },
                  backgroundColor: buttonColor,
                  horizontalPadding: 46,
                  verticalPadding: 15,
                  borderRadius: 12,
                  textStyle: getHeebo(FontWeight.w700, 16, Colors.white),
                ),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    context.go('/onboarding3');
                  },
                  backgroundColor: buttonColor,
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
