import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparsh/email_verification/ui/emailVerificationPage.dart';
import 'package:sparsh/forgot_password/ui/forgotPasswordPage.dart';
import 'package:sparsh/home/ui/homePage.dart';
import 'package:sparsh/landing/ui/landingPage.dart';
import 'package:sparsh/signup/ui/signupPage.dart';
import 'package:sparsh/splashScreen/ui/splashPage.dart';

import 'consts.dart';
import 'login/ui/loginPage.dart';

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
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          appBarTheme: const AppBarTheme(elevation: 0),
          useMaterial3: true,
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: grey,
          )),
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
