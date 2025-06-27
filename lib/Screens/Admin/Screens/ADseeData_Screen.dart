import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADdata_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Widgets/ADppDrawer.dart';
import 'package:weathermonitoringapp/app_data.dart';

class ADSeeDataScreen extends StatefulWidget {
  const ADSeeDataScreen({Key? key}) : super(key: key);

  static const screenRoute = '/ADSeeData_Screen';

  @override
  State<ADSeeDataScreen> createState() => _ADSeeDataScreenState();
}

class _ADSeeDataScreenState extends State<ADSeeDataScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Data Types',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        backgroundColor: const Color.fromARGB(0, 149, 214, 234),
        elevation: 0,
      ),
      drawer: ADAppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: DataTypes_list.length,
              itemBuilder: (context, index) {
                final dataType = DataTypes_list[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(dataType.backgroundImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ADDataScreen.screenRoute,
                        arguments: dataType,
                      );
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Image.network(
                        dataType.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        dataType.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Transform.scale(
              scale: 0.99,
              child: Lottie.network(
                'https://lottie.host/e9fef902-2bba-44ac-8d45-722d69d108c7/XeHQ8G1ncc.json',
                height: 250,
                width: 400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
