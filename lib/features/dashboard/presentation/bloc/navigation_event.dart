import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationItemTapped extends NavigationEvent {
  final int index;

  const NavigationItemTapped(this.index);

  @override
  List<Object> get props => [index];
}
