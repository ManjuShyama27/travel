import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/screens/login.dart';

import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: MyColor.orClr.withOpacity(0.3)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              'https://assets10.lottiefiles.com/packages/lf20_mdbdc5l7.json'),
          SizedBox(height: 15),
          Text(
            'Traveln',
            style: TextStyle(
                color: Colors.purple.withOpacity(0.7),
                fontSize: 28,
                fontWeight: FontWeight.w700),
          )
        ],
      )),
    ));
  }
}
