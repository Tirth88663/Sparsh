import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparsh/email_verification/ui/emailVerificationPage.dart';
import 'package:sparsh/login/bloc/login_bloc.dart';

import '../../../consts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _loginformkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginBloc loginBloc = LoginBloc();
  @override
  void initState() {
    loginBloc.add(LoginInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Email.";
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter Valid Email");
        }
        //reg expression for validation of domain
        if (!RegExp("\b*.com\$", caseSensitive: true).hasMatch(value)) {
          return ("Enter Valid Email");
        }
        return null;
      },
      onSaved: (value) {
        _loginformkey.currentState!.validate();
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: blue,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(CupertinoIcons.mail_solid, color: blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: orange),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid password.");
        }
        return null;
      },
      onSaved: (value) {
        _loginformkey.currentState!.validate();
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      cursorColor: blue,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(CupertinoIcons.lock_fill, color: blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: orange),
        ),
      ),
    );

    final userLoginButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 40,
      minWidth: width * 0.32,
      color: orange,
      splashColor: blue,
      onPressed: () {
        logIn(emailController.text, passwordController.text);
      },
      child: Text(
        "Log In",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: blue,
          ),
        ),
      ),
    );

    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case LoginNavToEmailVerificationActionState:
            Navigator.pushNamed(context, "/email");
            break;
          case LoginNavToPasswordResetActionState:
            Navigator.pushNamed(context, "/forgot");
            break;
          case LoginNavToSignupActionState:
            Navigator.pushReplacementNamed(context, "/signup");
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginInitial:
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: blue,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              // bottomSheet: SizedBox(
              //   height: width * 1.2,
              //   width: width,
              //   child: Form(
              //     key: _loginformkey,
              //     child: Padding(
              //       padding: EdgeInsets.only(
              //         top: width * 0.06,
              //         left: width * 0.06,
              //         right: width * 0.06,
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           emailField,
              //           SizedBox(height: width * 0.04),
              //           passwordField,
              //           SizedBox(height: width * 0.1),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             children: [
              //               TextButton(
              //                 child: Text(
              //                   "Forgot Password?",
              //                   style: GoogleFonts.poppins(
              //                     textStyle: const TextStyle(
              //                       fontWeight: FontWeight.w700,
              //                       fontSize: 16,
              //                       color: blue,
              //                     ),
              //                   ),
              //                 ),
              //                 onPressed: () =>
              //                     loginBloc.add(LoginPasswordForgotEvent()),
              //               ),
              //               userLoginButton,
              //             ],
              //           ),
              //           SizedBox(
              //             height: width * 0.04,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 "Don't have an account?",
              //                 style: GoogleFonts.poppins(
              //                   textStyle: const TextStyle(
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 16,
              //                   ),
              //                 ),
              //               ),
              //               TextButton(
              //                 child: Text("Signup",
              //                     style: GoogleFonts.poppins(
              //                       textStyle: const TextStyle(
              //                         fontWeight: FontWeight.w700,
              //                         fontSize: 16,
              //                         color: blue,
              //                       ),
              //                     )),
              //                 onPressed: () =>
              //                     loginBloc.add(SignupButtonClickedEvent()),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          //Title/Heading
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.15,
                              vertical: width * 0.2,
                            ),
                            child: Center(
                                child: Image.asset(
                                    "assets/logo-white-no-background.png")),
                          ),
                          Container(
                            height: width * 1.2,
                            width: width,
                            decoration: const BoxDecoration(
                              color: grey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Form(
                              key: _loginformkey,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: width * 0.08,
                                  left: width * 0.06,
                                  right: width * 0.06,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    emailField,
                                    SizedBox(height: width * 0.04),
                                    passwordField,
                                    SizedBox(height: width * 0.1),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          child: Text(
                                            "Forgot Password?",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: blue,
                                              ),
                                            ),
                                          ),
                                          onPressed: () => loginBloc
                                              .add(LoginPasswordForgotEvent()),
                                        ),
                                        userLoginButton,
                                      ],
                                    ),
                                    SizedBox(
                                      height: width * 0.04,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account?",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          child: Text("Signup",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: blue,
                                                ),
                                              )),
                                          onPressed: () => loginBloc
                                              .add(SignupButtonClickedEvent()),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  void logIn(String email, String password) async {
    if (_loginformkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                loginBloc.add(LoginButtonClickedEvent()),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
