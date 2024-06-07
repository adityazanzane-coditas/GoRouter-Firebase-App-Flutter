import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          centerTitle: false,
          title: Text(
            appLocalizations.books,
            style: getHeebo(
              FontWeight.w400,
              20,
              AppColors.blackTextColor,
            ),
          ),
        ),
        body: const Center(
          child: Text("No user is signed in"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: false,
        title: Text(
          appLocalizations.books,
          style: getHeebo(
            FontWeight.w400,
            20,
            AppColors.blackTextColor,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: user.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var bookData = snapshot.data!.docs[index].data();
                String? bookName = bookData["bookName"] as String?;
                String? bookDescription =
                    bookData["bookDescription"] as String?;

                if (bookName == null || bookDescription == null) {
                  return const ListTile(
                    title: Text("Invalid data"),
                  );
                }
                return ListTile(
                  title: Text(bookName),
                  onTap: () {
                    analytics.logEvent(
                      name: 'Book Selected',
                      parameters: {
                        'book_name': bookName,
                      },
                    );
                    context.push('/book/$bookName', extra: bookData);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text("No Books"),
            );
          }
        },
      ),
    );
  }
}
