import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weathermonitoringapp/Classes/Sensor.dart';
import 'package:weathermonitoringapp/app_palette.dart';

class SensorDetailScreen extends StatelessWidget {
  const SensorDetailScreen({Key? key}) : super(key: key);

  static const screenRoute = '/SensorDetail_Screen';

  @override
  Widget build(BuildContext context) {
    final Sensor sensor = ModalRoute.of(context)!.settings.arguments as Sensor;

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
            Text(
              '${sensor.name}',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
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
              height: 150,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 89, top: 50),
              child: Transform.scale(
                scale: 0.99,
                child: Lottie.network(
                  'https://lottie.host/c25d4962-d957-4750-94c4-fce218c91680/yubJHwH8Ja.json',
                  height: 200,
                  width: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
