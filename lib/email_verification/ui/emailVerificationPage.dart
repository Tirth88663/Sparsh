import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparsh/consts.dart';

import '../bloc/email_verification_bloc.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  final EmailVerificationBloc emailVerificationBloc = EmailVerificationBloc();

  @override
  void initState() {
    emailVerificationBloc.add(EmailVerificationInitialEvent());
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    } else {
      emailVerificationBloc.add(EmailVerificationDoneEvent());
    }
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      emailVerificationBloc.add(EmailVerificationDoneEvent());
      Fluttertoast.showToast(msg: "Email Successfully Verified");
      timer?.cancel();
    }
  }

  sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
      bloc: emailVerificationBloc,
      listenWhen: (previous, current) =>
          current is EmailVerificationActionState,
      buildWhen: (previous, current) =>
          current is! EmailVerificationActionState,
      listener: (context, state) {
        if (state is EmailVerificationDoneActionState) {
          Navigator.pushReplacementNamed(context, "/home");
        } else if (state is EmailVerificationNavToLandingScreenActionState) {
          Navigator.pushReplacementNamed(context, "/landing");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case EmailVerificationInitial:
            return Scaffold(
              backgroundColor: blue,
              body: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Check your Email',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Center(
                          child: Text(
                            'We have sent you a Email on  ${FirebaseAuth.instance.currentUser?.email}\n \n Please check spam folder if mail isn\'t in your inbox',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      const Center(
                          child: CircularProgressIndicator(
                        color: orange,
                      )),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Center(
                          child: Text(
                            'Verifying email....',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[300],
                            foregroundColor: blue,
                          ),
                          child: Text(
                            'Resend',
                            style: GoogleFonts.poppins(),
                          ),
                          onPressed: () async {
                            sendVerificationEmail();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: blue,
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            emailVerificationBloc.add(
                                EmailVerificationCancelButtonClickedEvent());
                          },
                        ),
                      ),
                    ],
                  ),
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
