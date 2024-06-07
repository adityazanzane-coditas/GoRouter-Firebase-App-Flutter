import 'package:flutter/material.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';

class BookDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> bookData;

  const BookDetailsScreen({
    super.key,
    required this.bookData,
  });

  @override
  Widget build(BuildContext context) {
    String bookName = bookData['bookName'] ?? 'No name provided';
    String bookDescription =
        bookData['bookDescription'] ?? 'No description provided';

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: false,
        title: Text(bookName),
        titleTextStyle: getHeebo(
          FontWeight.w600,
          20,
          AppColors.blackTextColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Text(
          bookDescription,
          style: getHeebo(
            FontWeight.w400,
            18,
            AppColors.blackTextColor,
          ),
        ),
      ),
    );
  }
}
