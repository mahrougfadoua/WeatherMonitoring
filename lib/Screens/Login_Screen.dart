import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADmain_Screen.dart';
import 'package:weathermonitoringapp/Screens/Main_Screen.dart';
import 'package:weathermonitoringapp/Screens/SignUp_Screen.dart';
import 'package:weathermonitoringapp/app_palette.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const screenRoute = '/Login_Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future signin() async {
    setState(() {
      showSpinner = true;
      emailError = null;
      passwordError = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      var userQuery = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: _emailController.text.trim())
          .get();

      if (userQuery.docs.isEmpty) {
        showUserDeletedDialog();
        return;
      }

      if (_emailController.text.trim() == 'admin@ad.dz') {
        Navigator.of(context).pushNamed(ADMainScreen.screenRoute);
      } else {
        Navigator.of(context).pushNamed(MainScreen.screenRoute);
      }
    } catch (e) {
      print(e);
      setState(() {
        showSpinner = false;
        emailError = 'Invalid email or password';
        passwordError = 'Invalid email or password';
      });
    } finally {
      setState(() {
        showSpinner = false;
      });
    }
  }

  void showUserDeletedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(220, 255, 255, 255),
          title: Text(
            'User Deleted',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 142, 23, 23),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'This user account has been deleted.',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 142, 23, 23),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void openSignupScreen() {
    setState(() {
      showSpinner = true;
    });
    Navigator.of(context).pushReplacementNamed(SignUpScreen.screenRoute);
    setState(() {
      showSpinner = false;
    });
  }

  void openMainScreen() {
    Navigator.of(context).pushReplacementNamed(MainScreen.screenRoute);
  }

  bool showSpinner = false;
  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          body: Stack(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Palette.firstColor,
                Palette.fifththtColor,
              ]),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 90.0, left: 22),
              child: Text(
                'Be in the know\nSign in!',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 255, 255, 255),
                ),
              )
                  .animate()
                  .fade(duration: 2000.ms)
                  .slideY(curve: Curves.easeIn)
                  .tint(color: Color.fromARGB(255, 23, 19, 77)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 115.0, left: 150),
            child: Transform.scale(
              scale: 0.99,
              child: Lottie.network(
                'https://lottie.host/8284f1a4-3679-43bc-9a24-21cf830d87e7/zgw6ajLetr.json',
                height: 200,
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            errorText: emailError,
                            errorStyle: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w700),
                            // suffixIcon: Icon(
                            //   Icons.check,
                            //   color: Color.fromARGB(255, 67, 71, 66),
                            // ),
                            label: Text(
                              'Email',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 23, 19, 77),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            errorText: passwordError,
                            errorStyle: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w700),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color.fromARGB(255, 67, 71, 66),
                              ),
                            ),
                            label: Text(
                              'Password',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 23, 19, 77),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //  Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Text(
                      //     'Forgot Password?',
                      //     style:  GoogleFonts.poppins(
                      //          fontSize: 14,
                      //          fontWeight: FontWeight.bold,
                      //          color: Color.fromARGB(255, 23, 19, 77),
                      //        ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 70,
                      ),
                      InkWell(
                        child: Container(
                          height: 55,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Palette.firstColor,
                              Palette.fifththtColor,
                              //  Palette.thirdColor,
                              //  Palette.fourthtColor
                            ]),
                          ),
                          child: Center(
                              child: Text(
                            'SIGN IN',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 23, 19, 77),
                            ),
                          )),
                        ),
                        onTap: () {
                          signin();
                        },
                      ),
                      SizedBox(
                        height: 110,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have account?",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                openSignupScreen();
                              },
                              child: Text(
                                "Sign up",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 23, 19, 77),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
