import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashLogInEvent>(splashLogInEvent);
    on<SplashLogOutEvent>(splashLogOutEvent);
  }

  FutureOr<void> splashLogInEvent(
      SplashLogInEvent event, Emitter<SplashState> emit) async {
    emit(SplashWaitingActionState());
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashNavToHomeActionState());
  }

  FutureOr<void> splashLogOutEvent(
      SplashLogOutEvent event, Emitter<SplashState> emit) async {
    emit(SplashWaitingActionState());
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashNavToLandingPageActionState());
  }
}
