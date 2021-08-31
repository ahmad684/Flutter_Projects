import 'package:blood_donation_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Widget example2 = SplashScreenView(
      home: MyApp(),
      duration: 5000,
      imageSize: 400,
      imageSrc: "images/sp.jpg",

      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash screen Demo',
      home: example2,
    );
  }
}