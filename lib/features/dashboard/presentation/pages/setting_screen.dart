import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navigate_app/core/locale_bloc/locale_bloc.dart';
import 'package:navigate_app/core/locale_bloc/locale_event.dart';
import 'package:navigate_app/core/theme/colors.dart';
import 'package:navigate_app/core/theme/font.dart';
import 'package:navigate_app/features/splash/presentation/page/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = sharedPref.getString('selectedLanguage') ?? 'en';
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('selectedLanguage', languageCode);
    context.read<LocaleBloc>().add(LocaleChanged(languageCode));
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  Future<void> _logout() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
    context.go('/signin');
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        title: Text(
          appLocalizations.settingScreen,
          style: getHeebo(FontWeight.w400, 20, Colors.black),
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
                  style: getHeebo(FontWeight.w500, 16, Colors.black),
                ),
                RadioListTile<String>(
                  title: Text(appLocalizations.english),
                  value: 'en',
                  groupValue: _selectedLanguage,
                  onChanged: (value) {
                    _changeLanguage(value!);
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile<String>(
                  title: Text(appLocalizations.hindi),
                  value: 'hi',
                  groupValue: _selectedLanguage,
                  onChanged: (value) {
                    _changeLanguage(value!);
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile<String>(
                  title: Text(appLocalizations.marathi),
                  value: 'mr',
                  groupValue: _selectedLanguage,
                  onChanged: (value) {
                    _changeLanguage(value!);
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile<String>(
                  title: Text(appLocalizations.arabic),
                  value: 'ar',
                  groupValue: _selectedLanguage,
                  onChanged: (value) {
                    _changeLanguage(value!);
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _logout,
            child: Text(appLocalizations.logout),
          ),
        ],
      ),
    );
  }
}
