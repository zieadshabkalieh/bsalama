import 'dart:async';

import 'package:bsalama/Screens/LoginScreen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  startTimer() async {
    var duration = Duration(seconds: 1);
    return new Timer(duration, loginRoute);
  }
  loginRoute() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginScreen()
    ));
  }
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }



  Widget initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: new Color(0xffF5591F),
              gradient: LinearGradient(
                colors: [(new Color(0xffF5591F)), (new Color(0xffF2861E))]
                    ,begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          Center(
            child: Container(
              child: Image.asset("images/1.png",width: 200,height: 200,),
            )
          )
        ],
      ),
    );
  }
}

