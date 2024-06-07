import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final TextStyle textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xff4052B4),
    this.horizontalPadding = 32.0,
    this.verticalPadding = 15.0,
    this.borderRadius = 12.0,
    this.textStyle = const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
