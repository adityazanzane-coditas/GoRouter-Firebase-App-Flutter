import 'package:flutter/material.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';

class AuthorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> authorData;

  const AuthorDetailsScreen({
    super.key,
    required this.authorData,
  });

  @override
  Widget build(BuildContext context) {
    String authorName = authorData['authorName'] ?? 'No name provided';
    String authorDescription =
        authorData['authorDescription'] ?? 'No description provided';

    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: false,
        title: Text(authorName),
        titleTextStyle: getHeebo(
          FontWeight.w600,
          20,
          AppColors.blackTextColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Text(
          authorDescription,
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
