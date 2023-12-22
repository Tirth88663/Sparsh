import 'package:flutter/material.dart';
import 'package:sparsh/consts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: width * 0.45,
                bottom: width * 0.06,
                left: width * 0.28,
                right: width * 0.28,
              ),
              color: Theme.of(context).colorScheme.primary,
              child: Image.asset("assets/icon-white-no-background.png"),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: width * 0.3,
                bottom: width * 0.35,
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2, // thickness
                          color: Theme.of(context).colorScheme.primary, // color
                        ),
                        borderRadius: BorderRadius.circular(48),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 16),
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2, // thickness
                          color: Theme.of(context).colorScheme.primary, // color
                        ),
                        borderRadius: BorderRadius.circular(48),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 88, vertical: 16),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
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
    );
  }
}
