import 'package:flutter/material.dart';
import 'package:quizeapp_task/FirstScreen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'main.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Widget example2 = SplashScreenView(

      duration: 5000,
      imageSize: 400,
      imageSrc: "asset/images/logo.png",

      textType: TextType.ColorizeAnimationText,

      backgroundColor: Colors.white, navigateRoute: FirstScreean(),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash screen Demo',

      home: example2,
    );
  }
}