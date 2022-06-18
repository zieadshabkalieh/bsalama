import 'package:bsalama/Screens/Home/mainhome.dart';
import 'package:bsalama/Screens/otp/timer.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'inputform.dart';

class OtpVerification extends StatefulWidget {
  final String extension;
  final String phone;

  OtpVerification(this.extension, this.phone);

  @override
  State<StatefulWidget> createState() => Otp();
}

class Otp extends State<OtpVerification> {
  String _verificationCode = "";
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late Inputform ani;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Center(
              child: Text(
                "Verify ${widget.extension}  ${widget.phone}",
                style: TextStyle(
                    color: Color(0xffF5591F),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Text(
              "We send your code to: x",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xffF5591F),
                fontWeight: FontWeight.bold,
              ),
            ),
            TimerApp(),
            SizedBox(height: 100),
            Inputform(onHoleCodeChanged: (String value) { setState(() {
              aniHoleCode = value;
            }); },),
            FlatButton(
              color: Color(0xffF5591F),
              textColor: Color(0xffffffff),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: aniHoleCode))
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => MainHome()), (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState!
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
              // /* {
              //   Navigator.push(context, MaterialPageRoute(
              //       builder: (context) => MainHome()));
              // */},
              child: Text("LOGIN"),
            ),
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.extension}${widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => MainHome()), (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID!;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }
@override
void initState() {
  // TODO: implement initState
  super.initState();
  ani = Inputform(
    onHoleCodeChanged: (v) {
      setState(() {
        aniHoleCode = v;
      });
    },
  );
  super.initState();
  _verifyPhone();

}
  String aniHoleCode = "";
}
