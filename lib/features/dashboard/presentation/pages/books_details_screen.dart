import 'package:flutter/material.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/core/theme/font.dart';


class BookDetailsScreen extends StatelessWidget {
  final String bookName;
  final String bookDescription;

  const BookDetailsScreen({
    super.key,
    required this.bookName,
    required this.bookDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        title: Text(bookName),
        titleTextStyle: getHeebo(FontWeight.w600, 20, blackTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Text(
          bookDescription,
          style: getHeebo(FontWeight.w400, 18, blackTextColor),
        ),
      ),
    );
  }
}
