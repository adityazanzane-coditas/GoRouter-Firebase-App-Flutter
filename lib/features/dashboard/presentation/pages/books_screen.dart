import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/core/theme/font.dart';
import 'package:navigate_app/features/dashboard/models/book_model.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        title: Text(
          appLocalizations.books,
          style: getHeebo(FontWeight.w400, 20, blackTextColor),
        ),
      ),
      body: ListView.builder(
        itemCount: localizedBooks.length,
        itemBuilder: (context, index) {
          final book = localizedBooks[index];
          return Column(
            children: [
              ListTile(
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
              if (index < localizedBooks.length)
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
