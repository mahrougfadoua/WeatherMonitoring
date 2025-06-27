import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weathermonitoringapp/Screens/Account_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADSensorType_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADaccount_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADdata_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADmain_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADmanageUser_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADsensorDetails_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADseeData_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADsetting_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADspecifyZone_Screen.dart';
import 'package:weathermonitoringapp/Screens/Data_Screen.dart';
import 'package:weathermonitoringapp/Screens/EditAccount_Screen.dart';
import 'package:weathermonitoringapp/Screens/Login_Screen.dart';
import 'package:weathermonitoringapp/Screens/Main_Screen.dart';
import 'package:weathermonitoringapp/Screens/SeeData_Screen.dart';
import 'package:weathermonitoringapp/Screens/SensorDetail_Screen.dart';
import 'package:weathermonitoringapp/Screens/SensorType_Screen.dart';
import 'package:weathermonitoringapp/Screens/SignUp_Screen.dart';
import 'package:weathermonitoringapp/Screens/TempGraphScreen.dart';
import 'package:weathermonitoringapp/Screens/Welcome_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCqQ88RXyS1Kc6-m1tiOunNIfxxi5AGTvk",
          authDomain: "weather-68131.firebaseapp.com",
          projectId: "weather-68131",
          storageBucket: "weather-68131.appspot.com",
          messagingSenderId: "583207762521",
          appId: "1:583207762521:web:51cb71651726c0ed418f48",
          measurementId: "G-7ZEHRNN6ML"));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Stream<User?> _authStateStream;

  @override
  void initState() {
    super.initState();
    _authStateStream = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authStateStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final currentUser = snapshot.data;
        String initialRoute;

        if (currentUser == null) {
          initialRoute = WelcomeScreen.screenRoute;
        } else if (currentUser.email == 'admin@ad.dz') {
          initialRoute = ADMainScreen.screenRoute;
        } else {
          initialRoute = MainScreen.screenRoute;
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: {
            LoginScreen.screenRoute: (ctx) => LoginScreen(),
            SignUpScreen.screenRoute: (ctx) => SignUpScreen(),
            MainScreen.screenRoute: (ctx) => MainScreen(),
            SeeDataScreen.screenRoute: (ctx) => SeeDataScreen(),
            AccountScreen.screenRoute: (ctx) => AccountScreen(),
            EditAccountScreen.screenRoute: (ctx) => EditAccountScreen(),
            WelcomeScreen.screenRoute: (ctx) => WelcomeScreen(),
            SensorTypeScreen.screenRoute: (ctx) => SensorTypeScreen(),
            SensorDetailScreen.screenRoute: (ctx) => SensorDetailScreen(),
            DataScreen.screenRoute: (ctx) => DataScreen(),
            TempGraphScreen.screenRoute: (ctx) => TempGraphScreen(),
            ADMainScreen.screenRoute: (ctx) => ADMainScreen(),
            ADSensorDetailScreen.screenRoute: (ctx) => ADSensorDetailScreen(),
            ADSensorTypeScreen.screenRoute: (ctx) => ADSensorTypeScreen(),
            ADSeeDataScreen.screenRoute: (ctx) => ADSeeDataScreen(),
            ADSettingScreen.screenRoute: (ctx) => ADSettingScreen(),
            ADAccountScreen.screenRoute: (ctx) => ADAccountScreen(),
            ADManageUserScreen.screenRoute: (ctx) => ADManageUserScreen(),
            ADSpecifyTheZoneScreen.screenRoute: (ctx) =>
                ADSpecifyTheZoneScreen(),
            ADDataScreen.screenRoute: (ctx) => ADDataScreen(),
          },
        );
      },
    );
  }
}
