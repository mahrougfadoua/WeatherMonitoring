import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weathermonitoringapp/Screens/SeeData_Screen.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const screenRoute = '/Main_Screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
            Palette.secondtColor,
          ]),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 90.0),
              child: Lottie.network(
                  'https://lottie.host/e47a5234-f74a-492d-b140-92415b576b2d/JRtaGT3wIt.json'),
            ),
            Text(
              'Let' '\'' 's get Started',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 255, 255, 255),
              ),
            )
                .animate()
                .fade(duration: 2000.ms)
                .slideY(curve: Curves.easeIn)
                .tint(color: Color.fromARGB(255, 17, 23, 56))
                .then()
                .slide(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to ',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Color.fromARGB(221, 255, 255, 255),
                      ),
                    ),
                    TextSpan(
                      text: 'ClimateCare',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\nyour go-to destination for real-time weather updates tailored specifically to your local area!',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Color.fromARGB(221, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 220),
              child: Transform.scale(
                scale: 1.8,
                child: Lottie.network(
                  'https://lottie.host/a069e43f-6486-4722-8e64-228f23af0b65/AuDc1OkHpH.json',
                  height: 90,
                  width: 90,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Container(
                    height: 53,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 230, 225, 225),
                      borderRadius: BorderRadius.circular(60),
                      //border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        'SEE DATA',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(SeeDataScreen.screenRoute);
                  },
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
