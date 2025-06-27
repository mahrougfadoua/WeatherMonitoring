import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:weathermonitoringapp/Screens/Login_Screen.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  static const screenRoute = '/EditAccount_Screen';

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late File file;
  var imagepicker = ImagePicker();
  String imageUrl = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  uploadImages(String userId) async {
    var imgpicked = await imagepicker.pickImage(source: ImageSource.gallery);

    if (imgpicked != null) {
      file = File(imgpicked.path);
      var nameimage = basename(imgpicked.path);
      print('==============================');
      print(nameimage);

      // Start Upload
      var refstorage = FirebaseStorage.instance.ref("images/$nameimage");
      await refstorage.putFile(file);

      var url = await refstorage.getDownloadURL();

      await _fireStore.collection("Users").doc(userId).update({'image': url});

      setState(() {
        imageUrl = url;
      });

      print('URL added to Firestore');
      print('url:$url');
    } else {
      print('Please Choose an Image');
    }
  }

  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  final user = FirebaseAuth.instance.currentUser!;
  final _fireStore = FirebaseFirestore.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

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

  Future<void> updateUsername(String userId, String newUsername) async {
    await _fireStore
        .collection('Users')
        .doc(userId)
        .update({'userName': newUsername});
  }

  Future<void> updatePhone(String userId, String newPhone) async {
    await _fireStore
        .collection('Users')
        .doc(userId)
        .update({'phone': newPhone});
  }

  Future<void> _showUpdateUsernameDialog(String userId) async {
    return showDialog(
      context: this.context,
      builder: (context) {
        return Scaffold(
          key: _scaffoldKey,
          body: Container(
            padding: EdgeInsets.only(top: 2),
            height: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Palette.secondtColor,
                  Palette.thirdColor,
                  Palette.fourthtColor,
                ],
              ),
            ),
            child: AlertDialog(
              backgroundColor: Color.fromARGB(220, 255, 255, 255),
              title: Text(
                'Update Username',
                style: GoogleFonts.poppins(
                    color: Palette.fifththtColor, fontWeight: FontWeight.bold),
              ),
              content: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Enter new username',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    // fontWeight: FontWeight.w500
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_usernameController.text.toLowerCase() == 'admin') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Username "admin" is not allowed.',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: Colors.red[700],
                        ),
                      );
                    } else if (_usernameController.text.startsWith('!') ||
                        _usernameController.text.startsWith('#') ||
                        _usernameController.text.startsWith('.') ||
                        _usernameController.text == "" ||
                        _usernameController.text.contains('!') ||
                        _usernameController.text.contains('#') ||
                        _usernameController.text.length > 15 ||
                        _usernameController.text.startsWith('-') ||
                        _usernameController.text.startsWith(',') ||
                        _usernameController.text.startsWith('%')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Invalide Username',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: Colors.red[700],
                        ),
                      );
                    } else {
                      await updateUsername(userId, _usernameController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Update',
                    style: GoogleFonts.poppins(
                      color: Palette.fifththtColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showUpdatePhoneDialog(String userId) async {
    return showDialog(
      context: this.context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Palette.firstColor,
          body: Container(
            padding: EdgeInsets.only(top: 2),
            height: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Palette.secondtColor,
                  Palette.thirdColor,
                  Palette.fourthtColor,
                ],
              ),
            ),
            child: AlertDialog(
              backgroundColor: Color.fromARGB(220, 255, 255, 255),
              title: Text(
                'Update Phone',
                style: GoogleFonts.poppins(
                    color: Palette.fifththtColor, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter new phone number',
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black,
                        // fontWeight: FontWeight.w500
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    //cursorColor: Colors.red
                  ),
                  SizedBox(height: 16),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    String phoneNumber = _phoneController.text.trim();
                    if (phoneNumber.length != 10 ||
                        phoneNumber.startsWith('00') ||
                        phoneNumber == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Invalid phone number. Please enter a 10-digit number, phone number should not starts with \'00\'',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: Colors.red[700],
                        ),
                      );
                    } else if (phoneNumber.startsWith('00')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Invalid phone number. Number dont starts with \'00\'',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: Colors.red[700],
                        ),
                      );
                    } else {
                      await updatePhone(userId, phoneNumber);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Update',
                    style: GoogleFonts.poppins(
                      color: Palette.fifththtColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
        // title: Text(
        //   "Account",
        //   style: GoogleFonts.poppins(color:Color.fromARGB(255, 240, 236, 236)),
        // ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 240, 236, 236),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.logout_outlined,
        //       size: 27,
        //       color:Color.fromARGB(255, 240, 236, 236),
        //     ),
        //     onPressed: () {
        //       signOut();
        //     },
        //   ),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Palette.secondtColor,
              Palette.thirdColor,
              Palette.fourthtColor,
            ],
          ),
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
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _fireStore.collection('Users').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final users = snapshot.data!.docs;
                              for (var user in users) {
                                final currentUserEmail = user.get('email');
                                final currentUserImage = user.get('image');
                                if (currentUserEmail == signedInUser.email) {
                                  return CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 26, 20, 20),
                                    backgroundImage: currentUserImage.isNotEmpty
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
                                  );
                                }
                              }
                            }

                            return SizedBox.shrink();
                          },
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
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await uploadImages(user.id);
                                        },
                                        icon: Icon(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          Icons.add_a_photo,
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
                        bottom: -10,
                        left: 80,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Card(
                    color: Color.fromARGB(183, 255, 255, 255),
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
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              _usernameController.text =
                                                  currentUserUserName ?? '';
                                              _showUpdateUsernameDialog(
                                                  user.id);
                                            },
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
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              _phoneController.text =
                                                  currentUserPhone ?? '';
                                              _showUpdatePhoneDialog(user.id);
                                            },
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
