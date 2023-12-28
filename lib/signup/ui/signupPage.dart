import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts.dart';
import '../../models/user_model.dart';
import '../bloc/signup_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    signupBloc.add(SignupInitialEvent());
    super.initState();
  }

  final SignupBloc signupBloc = SignupBloc();
  final _auth = FirebaseAuth.instance;

  final _signupformKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final mobileNumberEditingController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reEnterPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = RegExp(r'^.{4,}$');
        if (value!.isEmpty) {
          return ("Name is required for SignUp");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid name(Min. 4 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: blue,
      decoration: InputDecoration(
        labelText: 'Full Name',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(CupertinoIcons.profile_circled, color: blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "enter your full name.",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: orange),
        ),
      ),
    );

    final mobileNumberField = TextFormField(
      autofocus: false,
      controller: mobileNumberEditingController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        RegExp regex = RegExp(r'^.{10,}$');
        if (value!.isEmpty) {
          return ("Mobile Number is required for SignUp");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid number(10 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        mobileNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: blue,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(CupertinoIcons.phone_fill, color: blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "mobile number",
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: blue),
        ),
      ),
    );

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
        _signupformKey.currentState!.validate();
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
        _signupformKey.currentState!.validate();
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

    final reEnterPasswordField = TextFormField(
      autofocus: false,
      controller: reEnterPasswordController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Password is required for Signup");
        }
        if (value != passwordController.text) {
          return ("Please re-enter same password. Password doesn't match!");
        }
        return null;
      },
      onSaved: (value) {
        _signupformKey.currentState!.validate();
        reEnterPasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      cursorColor: blue,
      decoration: InputDecoration(
        labelText: 'Re-Enter Password',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(CupertinoIcons.lock_fill, color: blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Re-Enter Password",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: orange),
        ),
      ),
    );

    final signUpButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 40,
      minWidth: width * 0.32,
      color: orange,
      splashColor: blue,
      onPressed: () {
        signUp(emailController.text, passwordController.text);
      },
      child: Text(
        "Sign Up",
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

    return BlocConsumer<SignupBloc, SignupState>(
      bloc: signupBloc,
      listenWhen: (previous, current) => current is SignupActionState,
      buildWhen: (previous, current) => current is! SignupActionState,
      listener: (context, state) {
        if (state is SignupNavToEmailVerificationState) {
          Navigator.pushReplacementNamed(context, "/email");
        } else if (state is SignupNavToLoginState) {
          Navigator.pushReplacementNamed(context, "/login");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SignupInitial:
            return Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              backgroundColor: blue,
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
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
                          height: width * 1.8,
                          width: width,
                          decoration: const BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Form(
                            key: _signupformKey,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: width * 0.08,
                                left: width * 0.06,
                                right: width * 0.06,
                              ),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    nameField,
                                    SizedBox(height: width * 0.04),
                                    emailField,
                                    SizedBox(height: width * 0.04),
                                    passwordField,
                                    SizedBox(height: width * 0.04),
                                    reEnterPasswordField,
                                    SizedBox(height: width * 0.04),
                                    mobileNumberField,
                                    SizedBox(height: width * 0.1),
                                    signUpButton,
                                    SizedBox(
                                      height: width * 0.04,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an account?",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          child: Text("Login",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: blue,
                                                ),
                                              )),
                                          onPressed: () => signupBloc
                                              .add(SignupToLoginClickedEvent()),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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

  void signUp(String email, String password) async {
    _signupformKey.currentState!.validate();
    if (_signupformKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :)");

    signupBloc.add(SignupButtonClickedEvent());
  }
}
