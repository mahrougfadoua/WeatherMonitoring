import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADaccount_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADsensorType_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Screens/ADspecifyZone_Screen.dart';
import 'package:weathermonitoringapp/Screens/Admin/Widgets/forward_button.dart';
import 'package:weathermonitoringapp/Screens/Admin/Widgets/setting_item.dart';
import 'package:weathermonitoringapp/Screens/Admin/Widgets/setting_switch.dart';

class ADSettingScreen extends StatefulWidget {
  const ADSettingScreen({super.key});

  static const screenRoute = '/ADSetting_Screen';

  @override
  State<ADSettingScreen> createState() => _ADSettingScreenState();
}

class _ADSettingScreenState extends State<ADSettingScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    // Image.asset("assets/avatar.png", width: 70, height: 70),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Weather Application",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ADAccountScreen.screenRoute);
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Language",
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "English",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ADSensorTypeScreen.screenRoute);
                },
                child: SettingItem(
                  title: "Sensors",
                  icon: Ionicons.settings_sharp,
                  bgColor: Colors.blue.shade100,
                  iconColor: Colors.blue,
                  onTap: () {},
                ),
              ),
              // ForwardButton(onTap: () {}),
              const SizedBox(height: 20),
              SettingSwitch(
                title: "Appearance",
                icon: Ionicons.apps_outline,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ADSpecifyTheZoneScreen.screenRoute);
                },
                child: SettingItem(
                  title: "Specify the zone",
                  icon: Ionicons.location_outline,
                  bgColor: Colors.red.shade100,
                  iconColor: Colors.red,
                  onTap: () {},
                ),
              ),
              // SettingItem(
              //   title: "Help",
              //   icon: Ionicons.nuclear,
              //   bgColor: Colors.red.shade100,
              //   iconColor: Colors.red,
              //   onTap: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
