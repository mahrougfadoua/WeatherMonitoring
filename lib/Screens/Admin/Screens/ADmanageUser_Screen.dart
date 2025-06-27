import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class ADManageUserScreen extends StatefulWidget {
  const ADManageUserScreen({Key? key});

  static final screenRoute = '/ADManageUser_Screen';

  @override
  State<ADManageUserScreen> createState() => _ADManageUserScreenState();
}

class _ADManageUserScreenState extends State<ADManageUserScreen> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> _showDeleteConfirmation(String userId, String userName) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(236, 255, 255, 255),
          title: Text(
            'Confirm Delete',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 142, 23, 23),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete user: $userName?',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel delete
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 76, 147, 201),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                usersCollection.doc(userId).delete();
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
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
          'User Manage',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Color.fromARGB(255, 240, 236, 236),
            fontWeight: FontWeight.bold,
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
        child: StreamBuilder<QuerySnapshot>(
          stream: usersCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final users = snapshot.data!.docs;

              return ListView.builder(
                itemCount: users.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  final userData = user.data() as Map<String, dynamic>;

                  if (userData['email'] != 'admin@ad.dz') {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserProfileScreen(email: userData['email']),
                            ),
                          );
                        },
                        child: Card(
                          color: Color.fromARGB(183, 255, 255, 255),
                          elevation: 5.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 55.0,
                                      height: 55.0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Color(0xffCD82DE),
                                        backgroundImage: NetworkImage(
                                          userData['image'] ?? '',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          userData['userName'] ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 54, 54, 54),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          userData['email'] ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 54, 54, 54),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'PhoneNum: ${userData['phone'] ?? ''}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 54, 54, 54),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 70,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 216, 84, 84),
                                      size: 30.0,
                                    ),
                                    onPressed: () {
                                      _showDeleteConfirmation(
                                          user.id, userData['userName']);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      height: double.maxFinite,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Palette.fourthtColor,
                            Palette.thirdColor,
                            Palette.firstColor
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  final String? email;

  const UserProfileScreen({Key? key, this.email}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.fourthtColor,
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
      body: Container(
        padding: EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Palette.fourthtColor,
              Palette.thirdColor,
              Palette.firstColor
            ],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!.docs;

              QueryDocumentSnapshot<Object?>? user;

              try {
                user = users.firstWhere(
                  (user) => user.get('email') == widget.email,
                );
              } catch (e) {
                print(e);
              }

              if (user != null) {
                String username = user.get('userName') ?? 'Unknown User';
                String imageUrl = user.get('image');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Show the photo view when the user's photo is clicked
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PhotoViewScreen(
                              imageProvider: NetworkImage(imageUrl),
                              heroTag:
                                  username, // Unique hero tag for the photo view
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: username,
                        child: CircleAvatar(
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : null,
                          radius: 80,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: Text(
                                'Username',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                username,
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: Text(
                                'Email',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                user.get('email'),
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: Text(
                                'Phone',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                user.get('phone') ?? 'No Phone',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('User not found'),
                );
              }
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
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
