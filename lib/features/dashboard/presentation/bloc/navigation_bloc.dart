import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigate_app/features/dashboard/presentation/bloc/navigation_event.dart';
import 'package:navigate_app/features/dashboard/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(index: 0)) {
    on<NavigationItemTapped>((event, emit) {
      emit(NavigationState(index: event.index));
    });
  }
}