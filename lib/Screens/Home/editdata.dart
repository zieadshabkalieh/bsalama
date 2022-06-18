import 'dart:math';
import 'package:bsalama/Screens/Home/home.dart';
import 'package:bsalama/Screens/Home/readdata.dart';
import 'package:bsalama/Screens/Home/writedata.dart';
import 'package:bsalama/main.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';
import 'package:bsalama/Screens/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

import 'Model/following.dart';
import 'mainhome.dart';

class EditData extends StatefulWidget {
  @override
  // late String ID;
  // late String date;
  // late String time;
  // late String dest;
  // late String src;
  EditData(
      {required this.index,
      required this.currentID,
      required this.olddate,
      required this.oldtime,
      required this.des,
      required this.src,
      Key? key})
      : super(key: key);
  int index;
  String currentID;
  String olddate;
  String oldtime;
  String des;
  String src;

  State<StatefulWidget> createState() => EditFire();
}

class EditFire extends State<EditData> {
  // String ID = "";
  // String date = "";
  // String time = "";
  // String dest = "";
  // String src = "";
  // EditFire(this.ID, this.date, this.time, this.dest, this.src){
  //   currentID = ID;

  //   _destinationcontroller.text = dest;
  //   _sourcecontroller.text = src;
  // }
  int? index;
  String? currentID;
  String? olddate;
  String? oldtime;
  final _destinationcontroller = TextEditingController();
  final _sourcecontroller = TextEditingController();
  DatabaseReference databaseReference = MainHomeState.databaseReference;
  DateTime now = DateTime(2022, 12, 24, 5, 30);
  final hours = DateTime.now().hour.toString().padLeft(2, '0');
  final minutes = DateTime.now().minute.toString().padLeft(2, '0');
  String selectedTime = "";
  bool favdate = false;
  bool favtime = false;

  setdata() {
    print("current ID : $currentID");
    databaseReference.child("journeys").child(currentID!).remove();
    String newID = now.day.toString() +
        now.month.toString() +
        now.year.toString() +
        now.hour.toString() +
        now.minute.toString() +
        now.second.toString();
    // ReadFire.listID[index!] = newID;
    ReadFire.listID = [];
    databaseReference.child("journeys").child(newID).set({
      "date": now.day.toString() +
          "/" +
          now.month.toString() +
          "/" +
          now.year.toString(),
      "destination": _destinationcontroller.text,
      "source": _sourcecontroller.text,
      "source": _sourcecontroller.text,
      "time": now.hour.toString() +
          ":" +
          now.minute.toString() +
          ":" +
          now.second.toString()
    }).asStream();

  }

  // deletedataaaa() {
  //   // FirebaseAnimatedList(
  //   //     shrinkWrap: true,
  //   //     query: databaseReference.child("journeys"),
  //   //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
  //   //         Animation animation, int index) {
  //   //       // var value = Map<String, dynamic>.from(snapshot.value as Map);
  //   //       // var title = value["source"];
  //   //       // print(title);
  //   //       return Consumer<Following>(
  //   //         builder:
  //   //             (BuildContext context, Following value, Widget? child) {
  //   //           return ListView(
  //   //               scrollDirection: Axis.vertical,
  //   //               shrinkWrap: true,
  //   //               children: <Widget>[
  //   //                 (following,Text(Map<String, dynamic>.from(
  //   //                     snapshot.value as Map)["date"]).data.toString(),Text(Map<String, dynamic>.from(
  //   //                     snapshot.value as Map)["time"]).data.toString(),)
  //   //               ]);
  //   //         },
  //   //       );
  //   //     }),
  // }

  // Future  deletedata() async
  // {
  //   final database = await databaseReference.child("journeys").once();
  //
  //   List <String> users = [];
  //
  //   database.value.forEach((key,values) => users.add(key));
  //
  //   print(users);
  //   print(users.length);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: _destinationcontroller,
                decoration: InputDecoration(hintText: "Destination"),
              ),
              padding: EdgeInsets.all(32),
            ),
            Container(
              child: TextFormField(
                controller: _sourcecontroller,
                decoration: InputDecoration(hintText: "Source"),
              ),
              padding: EdgeInsets.all(32),
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(favdate
                          ? "${now.year}/${now.month}/${now.day}"
                          : "$olddate"),
                      onPressed: () async {
                        final date = await pickDate();
                        if (date == null) return;
                        final newDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          now.hour,
                          now.minute,
                        );
                        setState(() {
                          favdate = true;
                          now = newDateTime;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(favtime
                          ? "${now.hour}:${now.minute} $selectedTime"
                          : "$oldtime"),
                      onPressed: () async {
                        final time = await pickTime();
                        print("Picked time is $time");
                        if (time == null) return;
                        final newDateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          time.hour,
                          time.minute,
                        );
                        print("New Date Time = $newDateTime");
                        setState(() {
                          favtime = true;
                          now = newDateTime;
                          selectedTime = time.format(context);
                        });
                        selectedTime =
                            selectedTime.substring(selectedTime.length - 2);
                        print("Selected time is: $selectedTime");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(50),
              child: Center(
                child: FlatButton(
                  onPressed: () {
                    setdata();
                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      );

  @override
  void initState() {
    super.initState();

    // you can get the values like this
    index = widget.index;
    currentID = widget.currentID;
    olddate = widget.olddate;
    oldtime = widget.oldtime;
    _destinationcontroller.text = widget.des;
    _sourcecontroller.text = widget.src;
    print("${widget.index}");
    print("${widget.currentID}" +
        "${widget.olddate}" +
        "${widget.oldtime}" +
        "${widget.des}" +
        "${widget.src}");
  }
}
