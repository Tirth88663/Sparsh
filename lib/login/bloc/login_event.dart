part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {}

class LoginPasswordForgotEvent extends LoginEvent {}

class SignupButtonClickedEvent extends LoginEvent {}
