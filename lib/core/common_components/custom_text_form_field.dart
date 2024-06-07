import 'package:flutter/material.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;

  const CustomTextFormField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,
            style: getHeebo(FontWeight.w500, 14,
                AppColors.authTextColor,)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: getHeebo(
                FontWeight.w400, 16, AppColors.authTextColor,),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff8590A2), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff8590A2), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
