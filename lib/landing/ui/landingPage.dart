import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparsh/consts.dart';
import 'package:sparsh/landing/bloc/landing_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    landingBloc.add(LandingInitialEvent());
    super.initState();
  }

  LandingBloc landingBloc = LandingBloc();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<LandingBloc, LandingState>(
      bloc: landingBloc,
      listenWhen: (previous, current) => current is LandingActionState,
      buildWhen: (previous, current) => current is! LandingActionState,
      listener: (context, state) {
        if (state is LandingNavToSignupState) {
          Navigator.pushNamed(context, "/signup");
        }
        if (state is LandingNavToLoginState) {
          Navigator.pushNamed(context, "/login");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LandingInitial:
            return Scaffold(
              backgroundColor: blue,
              // bottomSheet: Container(
              //   height: width * 1.2,
              //   width: width,
              //   decoration: const BoxDecoration(
              //     color: grey,
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(30),
              //       topRight: Radius.circular(30),
              //     ),
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       ElevatedButton(
              //         onPressed: () =>
              //             landingBloc.add(LandingLoginClickedEvent()),
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.white,
              //           elevation: 0,
              //           shape: RoundedRectangleBorder(
              //             // side: const BorderSide(
              //             //   width: 2, // thickness
              //             //   color: Colors.black, // color
              //             // ),
              //             borderRadius: BorderRadius.circular(48),
              //           ),
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 120, vertical: 16),
              //         ),
              //         child: const Text(
              //           'Log In',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(height: 32),
              //       ElevatedButton(
              //         onPressed: () =>
              //             landingBloc.add(LandingSignupClickedEvent()),
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: orange,
              //           elevation: 0,
              //           shape: RoundedRectangleBorder(
              //             // side: const BorderSide(
              //             //   width: 2, // thickness
              //             //   color: Colors.black, // color
              //             // ),
              //             borderRadius: BorderRadius.circular(48),
              //           ),
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 88, vertical: 16),
              //         ),
              //         child: const Text(
              //           'Create Account',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.3,
                          vertical: width * 0.25,
                        ),
                        child: Center(
                            child: Image.asset(
                                "assets/icon-white-no-background.png")),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  landingBloc.add(LandingLoginClickedEvent()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  // side: const BorderSide(
                                  //   width: 2, // thickness
                                  //   color: Colors.black, // color
                                  // ),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 120, vertical: 16),
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () =>
                                  landingBloc.add(LandingSignupClickedEvent()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  // side: const BorderSide(
                                  //   width: 2, // thickness
                                  //   color: Colors.black, // color
                                  // ),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 88, vertical: 16),
                              ),
                              child: const Text(
                                'Create Account',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
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
