import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<LoginPasswordForgotEvent>(loginPasswordForgotEvent);
    on<SignupButtonClickedEvent>(signupButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavToEmailVerificationActionState());
  }

  FutureOr<void> loginPasswordForgotEvent(
      LoginPasswordForgotEvent event, Emitter<LoginState> emit) {
    emit(LoginNavToPasswordResetActionState());
  }

  FutureOr<void> signupButtonClickedEvent(
      SignupButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavToSignupActionState());
  }

  FutureOr<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }
}
