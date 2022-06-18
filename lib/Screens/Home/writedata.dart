import 'package:bsalama/Screens/Home/readdata.dart';
import 'package:bsalama/Screens/Home/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'mainhome.dart';

class WriteData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WriteFire();
}

class WriteFire extends State<WriteData> {
  final _destinationcontroller = TextEditingController();
  final _sourcecontroller = TextEditingController();

  DatabaseReference databaseReference = MainHomeState.databaseReference;
  DateTime now = DateTime(2022, 12, 24, 5, 30);
  final hours = DateTime.now().hour.toString().padLeft(2, '0');
  final minutes = DateTime.now().minute.toString().padLeft(2, '0');
  String selectedTime = "AM";
  bool favdate = false;
  bool favtime = false;

  setdata() {
    ReadFire.listID = [];
    databaseReference
        .child("journeys")
        .child(now.day.toString() +
            now.month.toString() +
            now.year.toString() +
            now.hour.toString() +
            now.minute.toString() +
            now.second.toString())
        .set({
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

  deletedataaaa() {
    // FirebaseAnimatedList(
    //     shrinkWrap: true,
    //     query: databaseReference.child("journeys"),
    //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
    //         Animation animation, int index) {
    //       // var value = Map<String, dynamic>.from(snapshot.value as Map);
    //       // var title = value["source"];
    //       // print(title);
    //       return Consumer<Following>(
    //         builder:
    //             (BuildContext context, Following value, Widget? child) {
    //           return ListView(
    //               scrollDirection: Axis.vertical,
    //               shrinkWrap: true,
    //               children: <Widget>[
    //                 (following,Text(Map<String, dynamic>.from(
    //                     snapshot.value as Map)["date"]).data.toString(),Text(Map<String, dynamic>.from(
    //                     snapshot.value as Map)["time"]).data.toString(),)
    //               ]);
    //         },
    //       );
    //     }),
  }

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
                          : "Select Date..."),
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
                        ? "${now.hour}:${now.minute}  $selectedTime"
                        : "Select Time..."),
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
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(50),
              child: Center(
                child: FlatButton(
                  onPressed: () {
                    setdata();
                    Snack_bar.showSnackBar(context, 'Journey has been Added');
                  },
                  child: Text("Add Journey"),
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
}
