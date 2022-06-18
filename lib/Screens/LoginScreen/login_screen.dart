import 'dart:ui';
import 'package:bsalama/Screens/SplashScreen/splash_screen.dart';
import 'package:bsalama/Screens/otp/otpverification.dart';
import 'package:flutter/material.dart';

import '../Home/snack_bar.dart';
import 'code_picker.dart';
import 'dropdown.dart';
import 'divide.dart';
import 'package:auth_buttons/auth_buttons.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IniteState();
}

class IniteState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }
}

Widget initWidget(BuildContext context) {
  TextEditingController _usercontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  return new MaterialApp(
      home: new Scaffold(
          body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),

                  topRight: Radius.circular(90)),
              color: new Color(0xffF5591F),
              gradient: LinearGradient(
                  colors: [(new Color(0xffF5591F)), (new Color(0xffF2861E))],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Center(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 20),
                  // alignment: Alignment.bottomRight,
                  child: Text(
                    "Bissalama",
                    style: TextStyle(color: Color(0xffffffff), fontSize: 20),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 20),
                  child: Image.asset("images/1.png"),
                  height: 90,
                  width: 90,
                ),
              ],
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(right: 30, left: 30, top: 5),
            child: Column(
              children: [
                Dropdown(),
                Container(
                  margin: EdgeInsets.only(left: 32, top: 10),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Icon(
                            Icons.person,
                            size: 30,
                            color: Color(0xffF5591F),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        child: Expanded(
                          child: TextField(
                            maxLength: 15,
                            keyboardType: TextInputType.name,
                            controller: _usercontroller,
                            cursorColor: Color(0xffF5591F),
                            decoration: InputDecoration(
                                hintText: "UserName",
                                enabledBorder: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    CodePicker(),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: TextField(
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: _phonecontroller,
                            cursorColor: Color(0xffF5591F),
                            decoration: InputDecoration(
                                hintText: "Phone Number",
                                enabledBorder: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 24),
                    FlatButton(
                      color: Color(0xffF5591F),
                      textColor: Color(0xffffffff),
                      onPressed: () {
                        if(_usercontroller.text != null && _phonecontroller.text != null) {
                          try {
                            if ("${_phonecontroller.text[0]}" == "0") {
                              _phonecontroller.text =
                                  _phonecontroller.text.substring(1);
                            }
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    OtpVerification(MyCodePicker.extention,
                                        _phonecontroller.text)));
                          }catch(e){
                            print(e);
                          }
                          } else {
                          Snack_bar.showSnackBar(context, 'Please Fill All Gaps');
                        }

                      },
                      child: Text("LOGIN"),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Align(
                    alignment: FractionalOffset.bottomCenter, child: Divide()),
              ],
            ))
      ]))));
}

