import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/core/theme/font.dart';
import 'package:navigate_app/features/dashboard/models/author_model.dart';

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final List<Author> localizedAuthors = [
      Author(
        name: appLocalizations.authorOne,
        description: appLocalizations.authorOneDescription,
      ),
      Author(
        name: appLocalizations.authorTwo,
        description: appLocalizations.authorTwoDescription,
      ),
      Author(
        name: appLocalizations.authorThree,
        description: appLocalizations.authorThreeDescription,
      ),
      Author(
        name: appLocalizations.authorFour,
        description: appLocalizations.authorFourDescription,
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        title: Text(
          appLocalizations.authors,
          style: getHeebo(FontWeight.w400, 20, blackTextColor),
        ),
      ),
      body: ListView.builder(
        itemCount: localizedAuthors.length,
        itemBuilder: (context, index) {
          final author = localizedAuthors[index];
          return Column(
            children: [
              ListTile(
                title: Text(
                  author.name,
                  style: getHeebo(FontWeight.w400, 16, blackTextColor),
                ),
                onTap: () {
                  context.push(
                    '/author/${author.name}',
                    extra: author,
                  );
                },
              ),
              if (index < localizedAuthors.length)
                const Divider(
                  height: 0,
                ),
            ],
          );
        },
      ),
    );
  }
}
