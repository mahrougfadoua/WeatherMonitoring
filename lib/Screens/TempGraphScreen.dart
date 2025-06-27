// ignore_for_file: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:lottie/lottie.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';

class TempGraphScreen extends StatefulWidget {
  TempGraphScreen({Key? key}) : super(key: key);

  static const screenRoute = '/TempGraph_Screen';

  @override
  _TempGraphScreenState createState() => _TempGraphScreenState();
}

class _TempGraphScreenState extends State<TempGraphScreen> {
  final databaseRef = FirebaseDatabase.instance.ref().child('te');
  final databaseRefT = FirebaseDatabase.instance.ref().child('time');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<DataSnapshot>(
          future: databaseRef.once().then((snapshot) => snapshot.snapshot),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var data = snapshot.data!.value as Map<dynamic, dynamic>;
              var numbers = data.values.toList();

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.timer_outlined, // my timer icon 
                      color: Colors.black,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: numbers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              '${numbers[index]} °C',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              '${DateTime.now().subtract(Duration(minutes: (index + 1) * 30)).hour}:${DateTime.now().subtract(Duration(minutes: (index + 1) * 30)).minute}', 
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
