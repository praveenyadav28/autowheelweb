
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:autowheelweb/onboarding/Login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
       LoginScreen()
     ), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Center(
        child: Image.asset("assets/AutoWheel Logo.jpg",height: MediaQuery.of(context).size.height*0.4,width:  MediaQuery.of(context).size.width*0.8,),
      ),
    );
  }
}
