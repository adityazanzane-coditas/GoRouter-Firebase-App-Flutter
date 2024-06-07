import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigate_app/core/constants/color_constants.dart';

TextStyle getHeebo(FontWeight fontWeight, double fontSize, Color fontColor) {
  return GoogleFonts.getFont(
    AppFonts.heeboFontFamily,
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: fontColor,
  );
}
