part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginNavToEmailVerificationActionState extends LoginActionState {}

class LoginNavToPasswordResetActionState extends LoginActionState {}

class LoginNavToSignupActionState extends LoginActionState {}
