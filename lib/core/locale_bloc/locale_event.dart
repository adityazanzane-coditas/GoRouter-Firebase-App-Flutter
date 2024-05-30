import 'package:equatable/equatable.dart';

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();
}

class LocaleChanged extends LocaleEvent {
  final String languageCode;

  const LocaleChanged(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}
