import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screens/historyScreen.dart';
import 'package:flutter_application_2/Screens/homeScreen.dart';
import 'package:flutter_application_2/Screens/predictionScreen.dart';
import 'package:flutter_application_2/Screens/visu.dart';
import 'package:flutter_application_2/Screens/visualizationScreen.dart';
import 'package:flutter_application_2/Widgets/loading.dart';
import 'package:flutter_application_2/Widgets/splashScreen.dart';
import 'package:flutter_application_2/Widgets/splashScreenNew.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Monkey Detection',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreenNew());
  }
}
