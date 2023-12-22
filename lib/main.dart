import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparsh/pages/emailVerificationPage.dart';
import 'package:sparsh/pages/forgotPasswordPage.dart';
import 'package:sparsh/pages/homePage.dart';
import 'package:sparsh/pages/landingPage.dart';
import 'package:sparsh/pages/loginPage.dart';
import 'package:sparsh/pages/signupPage.dart';
import 'package:sparsh/pages/splashPage.dart';

import 'consts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyDk1fPflSA8qTPniSrWWn2f-H9sxgsyVPc", // Your apiKey
      //   appId: "1:794393783587:web:0112f3939b4d111742f096", // Your appId
      //   messagingSenderId: "794393783587", // Your messagingSenderId
      //   projectId: "sparsh-3bee7", // Your projectId
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sparsh',
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: backgroundColor,
          onBackground: textColor,
          primary: primaryColor,
          onPrimary: primaryFgColor,
          secondary: secondaryColor,
          onSecondary: secondaryFgColor,
          tertiary: accentColor,
          onTertiary: accentFgColor,
          surface: backgroundColor,
          onSurface: textColor,
          error: Brightness.light == Brightness.light
              ? Color(0xffB3261E)
              : Color(0xffF2B8B5),
          onError: Brightness.light == Brightness.light
              ? Color(0xffFFFFFF)
              : Color(0xff601410),
        ),
        appBarTheme: const AppBarTheme(elevation: 0),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashPage(),
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/email': (context) => const EmailVerificationPage(),
        '/forgot': (context) => const ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
