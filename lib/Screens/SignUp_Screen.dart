import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weathermonitoringapp/Screens/Login_Screen.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const screenRoute = '/SignUp_Screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmepasswordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordVisible2 = false;

  String? _userNameError;
  String? _phoneError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  Future signup() async {
    setState(() {
      _userNameError =
          _userNameController.text.isEmpty ? 'Username cannot be empty' : null;
      _phoneError =
          _phoneController.text.isEmpty ? 'Phone number cannot be empty' : null;
      _emailError =
          _emailController.text.isEmpty ? 'Email cannot be empty' : null;
      _passwordError =
          _passwordController.text.isEmpty ? 'Password cannot be empty' : null;
      _confirmPasswordError = _confirmepasswordController.text.isEmpty
          ? 'Confirm Password cannot be empty'
          : null;

      if (_passwordController.text.isNotEmpty &&
          _passwordController.text != _confirmepasswordController.text) {
        _confirmPasswordError = 'Passwords do not match';
        _passwordError = 'Passwords do not match';
        _emailError = null;
        _phoneError = null;
        _userNameError = null;
      }
    });

    setState(() {
      _userNameError =
          _userNameController.text.isEmpty ? 'Username cannot be empty' : null;
      _phoneError =
          _phoneController.text.isEmpty ? 'Phone number cannot be empty' : null;
      _emailError =
          _emailController.text.isEmpty ? 'Email cannot be empty' : null;
      _passwordError =
          _passwordController.text.isEmpty ? 'Password cannot be empty' : null;
      _confirmPasswordError = _confirmepasswordController.text.isEmpty
          ? 'Confirm Password cannot be empty'
          : null;

      if (_passwordController.text.isNotEmpty &&
          _passwordController.text != _confirmepasswordController.text) {
        _confirmPasswordError = 'Passwords do not match';
        _passwordError = 'Passwords do not match';
        _emailError = null;
        _phoneError = null;
        _userNameError = null;
      }
    });

    if (_userNameController.text.isEmpty) {
      setState(() {
        _userNameError = 'Username cannot be empty';
      });
    }

    if (_phoneController.text.isEmpty) {
      setState(() {
        _phoneError = 'Phone number cannot be empty';
      });
    }

    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Email cannot be empty';
      });
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password cannot be empty';
      });
    }

    if (_confirmepasswordController.text.isEmpty) {
      setState(() {
        _confirmPasswordError = 'Confirm Password cannot be empty';
      });
    }

    if (_userNameController.text.startsWith('.') ||
        _userNameController.text == "" ||
        _userNameController.text.contains('!') ||
        _userNameController.text.contains('#') ||
        _userNameController.text.length > 15 ||
        _userNameController.text.startsWith('-') ||
        _userNameController.text.startsWith(',') ||
        _userNameController.text.startsWith('%') ||
        _userNameController.text == 'admin' ||
        _userNameController.text == 'ADMIN') {
      _userNameError = 'Invalide Username';
    }

    if (_phoneController.text.length != 10 ||
        _phoneController.text.startsWith('00')) {
      _phoneError = 'Invalide Phone Number';
    }

    if (_confirmepasswordController.text.isEmpty &&
        _passwordController.text.isNotEmpty) {
      _passwordError = null;
    }

    try {
      if (_userNameError == null &&
          _phoneError == null &&
          _emailError == null &&
          _passwordError == null &&
          _confirmPasswordError == null) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        addUserDetails(
          _userNameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _phoneController.text.trim(),
        );
        Navigator.of(context).pushNamed(LoginScreen.screenRoute);
      } else {
        throw FirebaseAuthException(
          code: 'form-error',
          message: 'Please fix the form errors',
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: unused_local_variable
      String errorMessage = 'An error occurred';

      setState(() {});

      if (e.code == 'email-already-in-use') {
        setState(() {
          _emailError = 'Email is already registered';
          _phoneError = null;
          _userNameError = null;
          _confirmPasswordError = null;
          _passwordError = null;
        });
        errorMessage = 'Email is already registered';
      } else if (e.code == 'invalid-email') {
        setState(() {
          _emailError = 'Invalid email address';
          _phoneError = null;
          _userNameError = null;
          _confirmPasswordError = null;
          _passwordError = null;
        });
        errorMessage = 'Invalid email address';
      } else if (e.code == 'weak-password') {
        setState(() {
          _passwordError = 'Password is too weak';
          _confirmPasswordError = 'Password is too weak';
          _emailError = null;
          _phoneError = null;
          _userNameError = null;
        });

        errorMessage = 'Password is too weak';
      } else if (e.code == 'password-mismatch') {
        setState(() {});
        errorMessage = 'Confirmation password is incorrect';
      } else if (e.code == 'username-invalid') {
        setState(() {
          _userNameError = 'Invalid username';
          _emailError = null;
          _phoneError = null;
          _confirmPasswordError = null;
          _passwordError = null;
        });
        errorMessage = 'Invalid username';
      } else if (e.code == 'form-error') {
        print('Form has errors. Please fix them.');
      }
    }
  }

  Future addUserDetails(
      String userName, String email, String password, String phone) async {
    await FirebaseFirestore.instance.collection('Users').add({
      'userName': userName,
      'email': email,
      'password': password,
      'phone': phone,
      'image':
          'https://i.pinimg.com/564x/fb/27/41/fb27417d8671d75fba40a9ddf910d4d7.jpg'
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmepasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void openLoginScreen() {
    Navigator.of(context).pushReplacementNamed(LoginScreen.screenRoute);
  }

  void openSignupScreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }

  bool showSlider = false;

  void toggleCircularSlider() {
    setState(() {
      _showCircularSlider = !_showCircularSlider;
    });
  }

  bool _showCircularSlider = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmepasswordController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
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
          child: Padding(
            padding: EdgeInsets.only(top: 80.0, left: 22),
            child: Text(
              'Create Your\nAccount',
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
                .animate()
                .fade(duration: 2000.ms)
                .slideY(curve: Curves.easeIn)
                .tint(color: Color.fromARGB(255, 23, 19, 77)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 220),
          child: Transform.scale(
            scale: 1.8,
            child: Lottie.network(
              'https://lottie.host/868aea04-b07a-4d0e-a456-010ae98d9bdc/hMnnnlM8XQ.json',
              height: 200,
              width: 200,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
                      controller: _userNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _userNameError,
                          errorStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                          // suffixIcon: Icon(
                          //   Icons.check,
                          //   color: Color.fromARGB(255, 67, 71, 66),
                          // ),
                          label: Text(
                            'usename',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 23, 19, 77),
                            ),
                          )),
                    ),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          errorText: _phoneError,
                          errorStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                          // suffixIcon: Icon(
                          //   Icons.check,
                          //   color: Color.fromARGB(255, 67, 71, 66),
                          // ),
                          label: Text(
                            'phone',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 23, 19, 77),
                            ),
                          )),
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          errorText: _emailError,
                          errorStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                          // suffixIcon: Icon(
                          //   Icons.check,
                          //   color: Color.fromARGB(255, 67, 71, 66),
                          // ),
                          label: Text(
                            'Email',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 23, 19, 77),
                            ),
                          )),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _passwordError,
                          errorStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
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
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 23, 19, 77),
                            ),
                          )),
                    ),
                    TextField(
                      controller: _confirmepasswordController,
                      obscureText: !_isPasswordVisible2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _confirmPasswordError,
                          errorStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible2 = !_isPasswordVisible2;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromARGB(255, 67, 71, 66),
                            ),
                          ),
                          label: Text(
                            'Confirm Password',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 23, 19, 77),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    InkWell(
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [Palette.firstColor, Palette.thirdColor]),
                        ),
                        child: Center(
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 23, 19, 77)),
                          ),
                        ),
                      ),
                      onTap: () {
                        signup();
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Do you have account?",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () {
                              openLoginScreen();
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(

                                  ///done login page
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
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
    ));
  }
}
