import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sparsh/pages/homePage.dart';

import 'landingPage.dart';
import 'loginPage.dart';

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
        Fluttertoast.showToast(msg: 'signed out!');
      } else {
        Fluttertoast.showToast(msg: 'signed in!');
      }
    });
    super.initState();
    navigateToHome();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    FirebaseAuth.instance.currentUser == null
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
          )
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var iconLeftPadding = width * 0.3;
    var iconRightPadding = width * 0.3;
    var iconTopPadding = width * 0.32;
    var iconBottomPadding = width * 0.0;

    var nameLeftPadding = width * 0.12;
    var nameRightPadding = width * 0.12;
    var nameTopPadding = width * 0.0;
    var nameBottomPadding = width * 0.3;

    return Scaffold(
      backgroundColor: const Color(0xFFecab55),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: iconTopPadding,
                  bottom: iconBottomPadding,
                  left: iconLeftPadding,
                  right: iconRightPadding),
              child: Image.asset("assets/icon-white-no-background.png"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: nameTopPadding,
                  bottom: nameBottomPadding,
                  left: nameLeftPadding,
                  right: nameRightPadding),
              child: Image.asset("assets/name-white-no-background.png"),
            ),
          ],
        ),
      ),
    );
  }
}
