import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../bloc/splash_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        splashBloc.add(SplashLogOutEvent());
      } else {
        splashBloc.add(SplashLogInEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  final SplashBloc splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<SplashBloc, SplashState>(
      bloc: splashBloc,
      listenWhen: (previous, current) => current is SplashActionState,
      buildWhen: (previous, current) => current is! SplashActionState,
      listener: (context, state) {
        if (state is SplashNavToLandingPageActionState) {
          Navigator.of(context).pushReplacementNamed("/landing");
        } else if (state is SplashNavToHomeActionState) {
          Navigator.pushReplacementNamed(context, "/email");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SplashWaitingActionState:
            return Scaffold(
              // backgroundColor: const Color(0xFFecab55),
              backgroundColor: const Color(0xff14213D),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.25),
                  child: Image.asset("assets/icon-white-no-background.png"),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
