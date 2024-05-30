import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locale_event.dart';
import 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(Locale('en'))) {
    on<LocaleChanged>(_onLocaleChanged);
    _loadInitialLocale();
  }

  Future<void> _loadInitialLocale() async {
    final sharedPref = await SharedPreferences.getInstance();
    final languageCode = sharedPref.getString('selectedLanguage') ?? 'en';
    add(LocaleChanged(languageCode));
  }

  void _onLocaleChanged(LocaleChanged event, Emitter<LocaleState> emit) {
    emit(LocaleState(Locale(event.languageCode)));
  }
}
