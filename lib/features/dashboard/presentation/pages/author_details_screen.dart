import 'package:flutter/material.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/core/theme/font.dart';


class AuthorDetailsScreen extends StatelessWidget {
  final String authorName;
  final String authorDescription;

  const AuthorDetailsScreen({
    super.key,
    required this.authorName,
    required this.authorDescription,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        title: Text(authorName),
        titleTextStyle: getHeebo(FontWeight.w600, 20, blackTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Text(
          authorDescription,
          style: getHeebo(FontWeight.w400, 18, blackTextColor),
        ),
      ),
    );
  }
}
