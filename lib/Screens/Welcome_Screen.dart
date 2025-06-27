import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weathermonitoringapp/Screens/Login_Screen.dart';
import 'package:weathermonitoringapp/Screens/SignUp_Screen.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const screenRoute = '/Welcome_Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 95, 165, 197),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Palette.firstColor,
            Palette.fifththtColor,
            //  Palette.thirdColor,
            //  Palette.fourthtColor
          ]),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 130.0),
              child: Lottie.network(
                  'https://lottie.host/396a5ab2-1a38-4705-83ba-81d7772ea3f1/XUnFsi6SUj.json'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Welcome Back',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 255, 255, 255),
                //fontSize: 30,
                //color: Colors.white
              ),
            )
                .animate()
                .fade(duration: 2000.ms)
                .slideY(curve: Curves.easeIn)
                .tint(color: Colors.amber),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: Container(
                height: 53,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    'SIGN IN',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              },
              child: Container(
                height: 53,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            const Spacer(),
            // Text(
            //   'Login with Social Media',
            //    style: GoogleFonts.poppins(
            //       fontSize: 15,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white
            //   )),//
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image(
                //   image: AssetImage('assets/instagram.png'),
                //   width: 30,
                //   height: 70,
                // ),
                SizedBox(width: 20),
                // Image(
                //   image: AssetImage('assets/facebook.png'),
                //   width: 30,
                //   height: 70,
                // ),
                SizedBox(width: 20),
                // Image(
                //   image: AssetImage('assets/twitter.png'),
                //   width: 30,
                //   height: 70,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
