import 'dart:async';

import 'package:flutter/material.dart';

class TimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OTPTimer();

}

class OTPTimer extends State<TimerApp> {
  int seconds = 30;
  Timer ?_timer;

  void _startTimer() {
    // seconds = 30;
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // if (seconds > 0) {
      //   setState(() =>
      //   seconds--);
      // } else {
      //   _timer?.cancel();
      // }
    });
}

@override
Widget build(BuildContext context) {
  _startTimer();
  return Center(
    child: Text(
      'This code will expired in: 00:00:$seconds',
      style: TextStyle(
        color: Color(0xffF5591F),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),
  );
}}
