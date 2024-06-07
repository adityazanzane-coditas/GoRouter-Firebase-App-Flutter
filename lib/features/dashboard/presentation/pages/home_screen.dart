import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final message = arguments is RemoteMessage ? arguments : null;
    final appLocalizations = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          centerTitle: false,
          title: Text(
            appLocalizations.home,
            style: getHeebo(
              FontWeight.w500,
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
        elevation: 0.6,
        centerTitle: false,
        title: Text(appLocalizations.home),
        titleTextStyle: getHeebo(
          FontWeight.w500,
          20,
          AppColors.blackTextColor,
        ),
      ),
      body: ListView(
        children: [
          if (message != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification Title: ${message.notification?.title ?? 'No Title'}',
                    style:
                        getHeebo(FontWeight.w500, 18, AppColors.blackTextColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Notification Body: ${message.notification?.body ?? 'No Body'}',
                    style:
                        getHeebo(FontWeight.w400, 16, AppColors.blackTextColor),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appLocalizations.books,
              style: getHeebo(FontWeight.w500, 20, AppColors.blackTextColor),
            ),
          ),
          StreamBuilder(
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var bookData = snapshot.data!.docs[index].data();
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 16),
                          minVerticalPadding: 0,
                          title: Text(
                            bookData["bookName"],
                            style: getHeebo(
                                FontWeight.w400, 16, AppColors.blackTextColor),
                          ),
                          onTap: () {
                            analytics.logEvent(
                              name: 'Book Selected',
                              parameters: {
                                'book_name': bookData["bookName"],
                              },
                            );
                            context.push('/book/${bookData["bookName"]}',
                                extra: bookData);
                          },
                        ),
                        if (index < snapshot.data!.docs.length)
                          const Divider(
                            height: 0,
                          ),
                      ],
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appLocalizations.authors,
              style: getHeebo(FontWeight.w500, 20, AppColors.blackTextColor),
            ),
          ),
          StreamBuilder(
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var authorData = snapshot.data!.docs[index].data();
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 16),
                          minVerticalPadding: 0,
                          title: Text(
                            authorData["authorName"],
                            style: getHeebo(
                                FontWeight.w400, 16, AppColors.blackTextColor),
                          ),
                          onTap: () {
                            analytics.logEvent(
                              name: 'Author Selected',
                              parameters: {
                                'author_name': authorData["authorName"],
                              },
                            );
                            context.push('/author/${authorData["authorName"]}',
                                extra: authorData);
                          },
                        ),
                        if (index < snapshot.data!.docs.length)
                          const Divider(
                            height: 0,
                          ),
                      ],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No Authors"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
