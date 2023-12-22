part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

abstract class SplashActionState extends SplashState {}

class SplashInitial extends SplashState {}

class SplashWaitingActionState extends SplashState {}

class SplashNavToLandingPageActionState extends SplashActionState {}

class SplashNavToHomeActionState extends SplashActionState {}
