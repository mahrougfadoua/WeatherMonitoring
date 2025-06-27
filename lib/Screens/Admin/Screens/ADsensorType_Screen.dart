import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADsensorDetails_Screen.dart';
import 'package:weathermonitoringapp/app_data.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class ADSensorTypeScreen extends StatelessWidget {
  const ADSensorTypeScreen({Key? key}) : super(key: key);

  static const screenRoute = '/ADSensorsType_Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sensors',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.firstColor,
      ),
      body: ListView.builder(
        itemCount: SensorsTypes_list.length,
        itemBuilder: (context, index) {
          final sensor = SensorsTypes_list[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ADSensorDetailScreen.screenRoute,
                  arguments: sensor,
                );
              },
              title: Text(
                sensor.name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              //subtitle: Text(sensor.description),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
