import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate_app/core/locale_bloc/locale_bloc.dart';
import 'package:navigate_app/core/locale_bloc/locale_event.dart';
import 'package:navigate_app/core/constants/color_constants.dart';
import 'package:navigate_app/core/locale_bloc/locale_state.dart';
import 'package:navigate_app/core/theme/text_style_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, localeState) {
        final selectedLanguage = localeState.locale.languageCode;
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            centerTitle: false,
            title: Text(
              appLocalizations.settingScreen,
              style: getHeebo(FontWeight.w400, 20, AppColors.blackTextColor),
            ),
            elevation: 0.6,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: appLocalizations.userName,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.language,
                      style: getHeebo(FontWeight.w500, 16,
                          AppColors.blackTextColor,),
                    ),
                    RadioListTile<String>(
                      title: Text(appLocalizations.english),
                      value: 'en',
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        context.read<LocaleBloc>().add(LocaleChanged(value!));
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    RadioListTile<String>(
                      title: Text(appLocalizations.hindi),
                      value: 'hi',
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        context.read<LocaleBloc>().add(LocaleChanged(value!));
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    RadioListTile<String>(
                      title: Text(appLocalizations.marathi),
                      value: 'mr',
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        context.read<LocaleBloc>().add(LocaleChanged(value!));
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    RadioListTile<String>(
                      title: Text(appLocalizations.arabic),
                      value: 'ar',
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        context.read<LocaleBloc>().add(LocaleChanged(value!));
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  final sharedPref = await SharedPreferences.getInstance();
                  await sharedPref.setBool('Login', false);
                  context.go('/signin');
                },
                child: Text(appLocalizations.logout),
              ),
            ],
          ),
        );
      },
    );
  }
}
