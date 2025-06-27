import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:weathermonitoringapp/Screens/Login_Screen.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class ADAccountScreen extends StatefulWidget {
  const ADAccountScreen({Key? key});

  static const screenRoute = '/ADAccount_Screen';

  @override
  State<ADAccountScreen> createState() => _ADAccountScreenState();
}

class _ADAccountScreenState extends State<ADAccountScreen> {
  late File file;
  var imagepicker = ImagePicker();
  String imageUrl = '';

  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  final user = FirebaseAuth.instance.currentUser!;
  final _fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showExitConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(220, 255, 255, 255),
          title: Text(
            'Confirm Exit',
            style: GoogleFonts.poppins(
                color: Palette.fifththtColor, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to sign out?',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(
                'Sign Out',
                style: GoogleFonts.poppins(
                  color: Palette.fifththtColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                signOut();
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      this.context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
      (route) => false,
    );
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Palette.secondtColor,
                Palette.thirdColor,
                Palette.fourthtColor,
              ],
            ),
          ),
        ),
        title: Text(
          "Account",
          style: GoogleFonts.poppins(
            color: Color.fromARGB(255, 240, 236, 236),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 240, 236, 236),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout_outlined,
              size: 27,
              color: Color.fromARGB(255, 240, 236, 236),
            ),
            onPressed: () {
              _showExitConfirmationDialog();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Palette.secondtColor,
            Palette.thirdColor,
            Palette.fourthtColor,
          ]),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PhotoViewScreen(
                                  imageProvider: NetworkImage(imageUrl),
                                  heroTag: 'userPhoto',
                                ),
                              ),
                            );
                          },
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _fireStore.collection('Users').snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final users = snapshot.data!.docs;
                                for (var user in users) {
                                  final currentUserEmail = user.get('email');
                                  final currentUserImage = user.get('image');
                                  if (currentUserEmail == signedInUser.email) {
                                    imageUrl = currentUserImage;
                                    return Hero(
                                      tag: 'userPhoto',
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            currentUserImage.isNotEmpty
                                                ? NetworkImage(currentUserImage)
                                                : null,
                                        child: Stack(
                                          children: [
                                            if (currentUserImage == null)
                                              Icon(
                                                Icons.person,
                                                color: Colors.blue,
                                                size: 45,
                                              ),
                                          ],
                                        ),
                                        radius: 60,
                                      ),
                                    );
                                  }
                                }
                              }
                              return SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _fireStore.collection('Users').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final users = snapshot.data!.docs;
                              for (var user in users) {
                                final currentUserEmail = user.get('email');
                                if (currentUserEmail == signedInUser.email) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [],
                                  );
                                }
                              }
                            }
                            return SizedBox.shrink();
                          },
                        ),
                        bottom: -10,
                        left: 80,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Card(
                    color: const Color.fromARGB(183, 255, 255, 255),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Email',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  signedInUser.email!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(115, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Username',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: StreamBuilder<QuerySnapshot>(
                              stream:
                                  _fireStore.collection('Users').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final users = snapshot.data!.docs;
                                  for (var user in users) {
                                    final currentUserEmail = user.get('email');
                                    final currentUserUserName =
                                        user.get('userName');
                                    if (currentUserEmail ==
                                        signedInUser.email) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            currentUserUserName ??
                                                'Unknown User',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromARGB(115, 0, 0, 0),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                }

                                return SizedBox.shrink();
                              },
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Phone',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: StreamBuilder<QuerySnapshot>(
                              stream:
                                  _fireStore.collection('Users').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final users = snapshot.data!.docs;
                                  for (var user in users) {
                                    final currentUserEmail = user.get('email');
                                    final currentUserPhone = user.get('phone');
                                    if (currentUserEmail ==
                                        signedInUser.email) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            currentUserPhone ?? 'No Phone',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromARGB(115, 0, 0, 0),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                }

                                return SizedBox.shrink();
                              },
                            ),
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
}

class PhotoViewScreen extends StatelessWidget {
  final ImageProvider<Object> imageProvider;
  final String heroTag;

  const PhotoViewScreen({
    required this.imageProvider,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(183, 255, 255, 255),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
          imageProvider: imageProvider,
          heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
        ),
      ),
    );
  }
}
