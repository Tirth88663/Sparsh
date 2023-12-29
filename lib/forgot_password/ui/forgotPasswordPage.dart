import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparsh/consts.dart';

import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void initState() {
    forgotPasswordBloc.add(ForgotPasswordInitialEvent());
    super.initState();
  }

  final ForgotPasswordBloc forgotPasswordBloc = ForgotPasswordBloc();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      bloc: forgotPasswordBloc,
      listenWhen: (previous, current) => current is ForgotPasswordActionState,
      buildWhen: (previous, current) => current is! ForgotPasswordActionState,
      listener: (context, state) {
        if (state is EmailSentSuccessActionState) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is ExceptionalActionState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ForgotPasswordInitial:
            return Scaffold(
              backgroundColor: blue,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  'Reset Password',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter your registered email \n You will receive an email for \n reset your password",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        //space
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        //email field
                        TextFormField(
                          autofocus: false,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Email.";
                            }
                            //reg expression for email validation
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter Valid Email");
                            }
                            //reg expression for validation of domain
                            // if (!RegExp("\b*.com\$", caseSensitive: true).hasMatch(value)) {
                            //   return ("Enter Valid Email");
                            // }
                            return null;
                          },
                          onSaved: (value) {
                            formKey.currentState!.validate();
                            emailController.text = value!;
                          },
                          style: const TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.next,
                          cursorColor: orange,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            prefixIcon: const Icon(CupertinoIcons.mail_solid,
                                color: grey),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Email",
                            hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(color: grey)),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: orange),
                            ),
                          ),
                        ),
                        //space
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        //sent button
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          height: 60,
                          minWidth: width * 0.35,
                          color: orange,
                          splashColor: Colors.green,
                          onPressed: () => resetPassword(),
                          child: Text(
                            "Reset Password",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

  Future resetPassword() async {
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        Fluttertoast.showToast(msg: 'Password Reset Email Sent');
        forgotPasswordBloc.add(ResetSuccessEvent());
      } on FirebaseAuthException catch (e) {
        print(e);
        Fluttertoast.showToast(msg: e.message.toString());
        forgotPasswordBloc.add(ExceptionalEvent());
      }
    }
  }
}
