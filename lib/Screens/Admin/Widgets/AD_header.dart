import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADaccount_Screen.dart';
import 'package:weathermonitoringapp/Screens/Login_Screen.dart';


class ADHeader extends StatefulWidget {
  @override
  State<ADHeader> createState() => _ADHeaderState();
}

class _ADHeaderState extends State<ADHeader> {
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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ADAccountScreen.screenRoute);
      },
      child: ListTile(
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          color: const Color.fromARGB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection("Users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data!.docs;

                    for (var user in users) {
                      final userEmail = user.get('email');
                      final userImage = user.get('image');
                      if (signedInUser.email == userEmail) {
                        return CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: userImage.isNotEmpty
                              ? NetworkImage(userImage)
                              : null,
                          child: Stack(
                            children: [
                              if (userImage == null)
                                Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: 45,
                                ),
                            ],
                          ),
                          radius: 40,
                        );
                      }
                    }
                  }
                  return SizedBox();
                },
              ),
              SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('Users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data!.docs;
                    for (var user in users) {
                      final currentUserEmail = user.get('email');
                      final currentUserUserName = user.get('userName');
                      if (currentUserEmail == signedInUser.email) {
                        return Text(
                          currentUserUserName ?? 'Unknown User',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        );
                      }
                    }
                  }

                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
