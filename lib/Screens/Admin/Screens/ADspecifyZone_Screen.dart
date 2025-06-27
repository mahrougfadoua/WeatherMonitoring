import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ADSpecifyTheZoneScreen extends StatefulWidget {
  const ADSpecifyTheZoneScreen({super.key});

  static const screenRoute = '/ADSpecifyTheZone_Screen';

  @override
  State<ADSpecifyTheZoneScreen> createState() => _ADSpecifyTheZoneScreenState();
}

class _ADSpecifyTheZoneScreenState extends State<ADSpecifyTheZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 200),
        child: Lottie.network(
          'https://lottie.host/76cad403-42ba-460f-a4b6-eeb5e2e6f938/Gxwtq9elVS.json',
          height: 350,
          width: 400,
        ),
      ),
    );
  }
}
