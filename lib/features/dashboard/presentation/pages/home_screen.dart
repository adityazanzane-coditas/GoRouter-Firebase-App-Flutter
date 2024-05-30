import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/core/theme/font.dart';
import 'package:navigate_app/features/dashboard/data/book_data.dart';
import 'package:navigate_app/features/dashboard/models/author_model.dart';
import 'package:navigate_app/features/dashboard/models/book_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final List<Book> localizedBooks = [
      Book(
        name: appLocalizations.bookOne,
        description: appLocalizations.bookOneDescription,
      ),
      Book(
        name: appLocalizations.bookTwo,
        description: appLocalizations.bookTwoDescription,
      ),
      Book(
        name: appLocalizations.bookThree,
        description: appLocalizations.bookThreeDescription,
      ),
      Book(
        name: appLocalizations.bookFour,
        description: appLocalizations.bookFourDescription,
      ),
    ];

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
        elevation: 0.6,
        centerTitle: false,
        title: Text(appLocalizations.home),
        titleTextStyle: getHeebo(FontWeight.w500, 20, blackTextColor),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appLocalizations.books,
              style: getHeebo(FontWeight.w500, 20, blackTextColor),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: localizedBooks.length,
            itemBuilder: (context, index) {
              final book = localizedBooks[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16),
                    minVerticalPadding: 0,
                    title: Text(
                      book.name,
                      style: getHeebo(FontWeight.w400, 16, blackTextColor),
                    ),
                    onTap: () {
                      context.push(
                        '/books/${book.name}',
                        extra: book,
                      );
                    },
                  ),
                  if (index < books.length)
                    const Divider(
                      height: 0,
                    ),
                ],
              );
            },
          ),
          // Authors Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appLocalizations.authors,
              style: getHeebo(FontWeight.w500, 20, blackTextColor),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: localizedAuthors.length,
            itemBuilder: (context, index) {
              final author = localizedAuthors[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16),
                    minVerticalPadding: 0,
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
        ],
      ),
    );
  }
}
