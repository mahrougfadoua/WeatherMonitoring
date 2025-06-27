// ignore_for_file: unused_local_variable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weathermonitoringapp/Classes/DataTypes.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key});

  static const screenRoute = '/Data_Screen';

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final databaseRef = FirebaseDatabase.instance.ref().child('');

  @override
  Widget build(BuildContext context) {
    final DataTypes datatypes =
        ModalRoute.of(context)!.settings.arguments as DataTypes;
    if (datatypes.id == '0') {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '${datatypes.name}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder<DataSnapshot>(
          
          future: databaseRef.once().then((snapshot) => snapshot.snapshot),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var data = snapshot.data!.value as Map<dynamic, dynamic>;
              var number = data['number'];
              if (number > -20 && number <= 10) {
              return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, 
                      color: Colors.black,
                    ),
                    Text(
                      'Cold',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Lottie.network(
                        'https://lottie.host/b2f4dfdb-b833-4f66-98a5-3769918273de/IqUqXikovN.json',
                        height: 300, 
                        width: 450, 
                      ),
                    ),
                    SizedBox(height: 100),
                    Text(
                      ' $number °C',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );}
              // -------------------------- sup a 10------
              else if (number > 10 && number <= 23) {
              return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, 
                      color: Colors.black,
                    ),
                    Text(
                      'Warm',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Lottie.network(
                        'https://lottie.host/51cbbf46-182b-4b1f-8061-392ffb290522/vYnRmsGY9z.json',
                        height: 400, 
                        width: 450, 
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      ' $number °C',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );}
            // -------------------- sup a 20
              else if (number > 23 && number <= 50) {
              return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, 
                      color: Colors.black,
                    ),
                    Text(
                      'Sunny',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Lottie.network(
                        'https://lottie.host/21a356ac-6704-482c-9ad4-253c8ec03c45/JKWe3o0Cj7.json',
                        height: 200, 
                        width: 400, 
                      ),
                    ),
                    SizedBox(height: 100),
                    Text(
                      ' $number °C',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );}

              else  {
              return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, 
                      color: Colors.black,
                    ),
                    Text(
                      'Deactivated',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Lottie.network(
                        'https://lottie.host/76cad403-42ba-460f-a4b6-eeb5e2e6f938/Gxwtq9elVS.json',
                        height: 350, 
                        width: 400, 
                      ),
                    ),
                    SizedBox(height: 100),
                    // Text(
                    //   ' $number °C',
                    //   style: GoogleFonts.poppins(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                  ],
                ),
              );}
            }
          },
        ),
      );
    } else if (datatypes.id == '1') {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '${datatypes.name}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder<DataSnapshot>(
          future: databaseRef.once().then((snapshot) => snapshot.snapshot),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var data = snapshot.data!.value as Map<dynamic, dynamic>;
              var hum = data['hum'];
              // --------------------- inf a 10

              if (hum >= 0 && hum < 30) {return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, 
                      color: Colors.black,
                    ),
                    Text(
                      'Dry',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Lottie.network(
                        'https://lottie.host/64829ba4-c472-45af-91b2-d84c13f3fdd2/NVWdjRqAHm.json',
                        height: 350, 
                        width: 400, 
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      ' $hum %',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );}
              else if (hum >= 30 && hum < 70) {return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, 
                      color: Colors.black,
                    ),
                    Text(
                      'Moderate',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Lottie.network(
                        'https://lottie.host/64829ba4-c472-45af-91b2-d84c13f3fdd2/NVWdjRqAHm.json',
                        height: 350, 
                        width: 400, 
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      ' $hum %',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );}
              else if (hum >= 70 && hum <= 100) {
                return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, 
                      color: Colors.black,
                    ),
                    Text(
                      'Damp',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Lottie.network(
                        'https://lottie.host/64829ba4-c472-45af-91b2-d84c13f3fdd2/NVWdjRqAHm.json',
                        height: 350, 
                        width: 400, 
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      ' $hum %',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
              }
              else {
                    return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, 
                      color: Colors.black,
                    ),
                    Text(
                      'Deactivated',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Lottie.network(
                        'https://lottie.host/76cad403-42ba-460f-a4b6-eeb5e2e6f938/Gxwtq9elVS.json',
                        height: 350, 
                        width: 400, 
                      ),
                    ),
                    SizedBox(height: 50),
                    // Text(
                    //   ' $hum %',
                    //   style: GoogleFonts.poppins(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                  ],
                ),
              );
              }
            
            }
          },
        ),
      );
    }

    else   return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${datatypes.name}',
          style: GoogleFonts.poppins(
             fontWeight: FontWeight.w600,),
        ),
      ),
      body: FutureBuilder<DataSnapshot>(
        future: databaseRef.once().then((snapshot) => snapshot.snapshot),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var data = snapshot.data!.value as Map<dynamic, dynamic>;
            var number = data['number'];
            return Center(
              child: Lottie.network(
                'https://lottie.host/76cad403-42ba-460f-a4b6-eeb5e2e6f938/Gxwtq9elVS.json',
                height: 350, 
                width: 400, 
              ),
            );
          }
        },
      ),
    );
  }
}
