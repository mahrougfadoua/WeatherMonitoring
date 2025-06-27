// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weathermonitoringapp/Screens/Login_Screen.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:weathermonitoringapp/Screens/Main_Screen.dart';
import 'package:weathermonitoringapp/Screens/SensorType_Screen.dart';
import 'package:weathermonitoringapp/Widgets/User_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
                Navigator.of(dialogContext).pop(); // Close the dialog
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
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return SidebarX(
        controller: SidebarXController(selectedIndex: 0),
        theme: SidebarXTheme(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: scaffoldBackgroundColor,
          textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          selectedTextStyle: TextStyle(color: Colors.white),
          itemTextPadding: EdgeInsets.only(left: 30),
          selectedItemTextPadding: EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            gradient: LinearGradient(
              colors: [accentCanvasColor, canvasColor],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          selectedIconTheme: IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme: SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: canvasColor,
          ),
        ),
        footerDivider: divider,
        headerBuilder: (context, extended) {
          return SafeArea(child: extended ? UserHeader() : Container()

              //
              );
        },
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              debugPrint('Home');
              Navigator.of(context)
                  .pushReplacementNamed(MainScreen.screenRoute);
            },
          ),
          // SidebarXItem(
          //     icon: Icons.search,
          //     label: 'Search',
          //     onTap: () {
          //       // Navigator.of(context).pushNamed(SearchScreen.screenRoute);
          //     }),
          // SidebarXItem(
          //   onTap: () {
          //     // Navigator.of(context).pushNamed(FilterScreen.screenRoute);
          //   },
          //   icon: Icons.filter_alt,
          //   label: 'Filter',
          // ),

          SidebarXItem(
            onTap: () {
              Navigator.of(context).pushNamed(SensorTypeScreen.screenRoute);
            },
            icon: Icons.accessibility,
            label: 'System',
          ),

          SidebarXItem(
            onTap: () {
              _showExitConfirmationDialog();
            },
            icon: Icons.logout_outlined,
            label: 'Sign out',
          ),
          SidebarXItem(
            iconWidget: FlutterLogo(size: 20),
            label: 'Flutter',
          ),
        ],
      );
    } catch (e) {
      return Container();
    }
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
