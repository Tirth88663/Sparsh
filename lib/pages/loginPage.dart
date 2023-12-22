import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparsh/pages/emailVerificationPage.dart';

import '../consts.dart';

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
        if (!RegExp("\b*@sunpharma.com\$", caseSensitive: true)
            .hasMatch(value)) {
          return ("Enter Valid Email");
        }
        return null;
      },
      onSaved: (value) {
        _loginformkey.currentState!.validate();
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(CupertinoIcons.mail_solid, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
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
      cursorColor: primaryColor,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(CupertinoIcons.lock_fill, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );

    final userLoginButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 1,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 60,
      minWidth: width * 0.35,
      color: Theme.of(context).colorScheme.primary,
      splashColor: Theme.of(context).colorScheme.tertiary,
      onPressed: () {
        logIn(emailController.text, passwordController.text);
      },
      child: Text(
        "Log In",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Column(
                children: [
                  //Title/Heading
                  Padding(
                    padding: EdgeInsets.only(
                      top: width * 0.12,
                      bottom: width * 0.2,
                      left: width * 0.08,
                      right: width * 0.08,
                    ),
                    child: Image.asset("assets/logo-white-no-background.png"),
                  ),

                  // Login Card
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: width * 0.05,
                      horizontal: width * 0.05,
                    ),
                    child: Form(
                      key: _loginformkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          emailField,
                          SizedBox(height: width * 0.04),
                          passwordField,
                          SizedBox(height: width * 0.1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/forgot'),
                              ),
                              userLoginButton,
                            ],
                          ),
                          SizedBox(
                            height: width * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    )),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/signup'),
                              ),
                            ],
                          ),
                        ],
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
  }

  void logIn(String email, String password) async {
    if (_loginformkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const EmailVerificationPage(),
                  ),
                ),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
