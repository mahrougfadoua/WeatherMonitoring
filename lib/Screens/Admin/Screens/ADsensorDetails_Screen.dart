import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathermonitoringapp/Classes/Sensor.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class ADSensorDetailScreen extends StatefulWidget {
  const ADSensorDetailScreen({Key? key}) : super(key: key);

  static const screenRoute = '/ADSensorDetail_Screen';

  @override
  State<ADSensorDetailScreen> createState() => _ADSensorDetailScreenState();
}

class _ADSensorDetailScreenState extends State<ADSensorDetailScreen> {
  bool isActive = false;
  final DatabaseReference _sensorRef =
      FirebaseDatabase.instance.reference().child('');

  @override
  void initState() {
    super.initState();
    loadSwitchState();
  }

  Future<void> loadSwitchState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isActive = prefs.getBool('isActive') ?? false;
    });
  }

  Future<void> saveSwitchState(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isActive', value);
  }

  void _showDeactivationAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Sensor Deactivated",
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 142, 23, 23),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "The sensor is now deactivated.",
            style: GoogleFonts.poppins(
              color: Colors.black,
              // fontWeight: FontWeight.w500
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "OK",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 142, 23, 23),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showActivationAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sensor Activated",
              style: GoogleFonts.poppins(
                  color: Palette.fifththtColor, fontWeight: FontWeight.bold)),
          content: Text(
            "The sensor is now activated.",
            style: GoogleFonts.poppins(
              color: Colors.black,
              // fontWeight: FontWeight.w500
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK",
                  style: GoogleFonts.poppins(
                      color: Palette.fifththtColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Sensor sensor = ModalRoute.of(context)!.settings.arguments as Sensor;

    if (sensor.id == '0') {
      return Scaffold(
        //backgroundColor: Palette.firstColor,
        appBar: AppBar(
          title: Text(
            '${sensor.name}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Palette.firstColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'ID: ${sensor.id}',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${sensor.name}',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CupertinoSwitch(
                    value: isActive,
                    onChanged: (value) {
                      setState(() {
                        isActive = value;
                        if (!isActive) {
                          _sensorRef.update({'allowUpdates': false});
                          _sensorRef.update({'number': 200});
                          _sensorRef.update({'hum': 200});
                          _showDeactivationAlert();
                        } else {
                          _sensorRef.update({'allowUpdates': true});
                          _sensorRef.update({'number': 20});
                          _sensorRef.update({'hum': 60});
                          _showActivationAlert();
                        }

                        saveSwitchState(value);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '${sensor.description}',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              SizedBox(height: 16),
              Image.network(
                sensor.imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        //backgroundColor: Palette.firstColor,
        appBar: AppBar(
          title: Text(
            '${sensor.name}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Palette.firstColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'ID: ${sensor.id}',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${sensor.name}',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // CupertinoSwitch(
                  //   value: isActive,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isActive = value;
                  //       if (!isActive) {
                  //         _sensorRef.update({'allowUpdates': false});
                  //         _sensorRef.update({'number': 200});
                  //         _sensorRef.update({'hum': 200});
                  //       }
                  //       else {
                  //         _sensorRef.update({'allowUpdates': true});
                  //         _sensorRef.update({'number': 20});
                  //         _sensorRef.update({'hum': 60});
                  //       }

                  //       saveSwitchState(value);
                  //     });
                  //   },
                  // ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '${sensor.description}',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              SizedBox(height: 16),
              Image.network(
                sensor.imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      );
    }
  }
}
