import 'package:bsalama/Screens/Home/Model/following.dart';
import 'package:bsalama/Screens/Home/editdata.dart';
import 'package:bsalama/Screens/Home/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'mainhome.dart';
import 'package:provider/provider.dart';
import 'Model/following.dart';

class ReadData extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ReadFire();
  late final DismissDirectionCallback onDissmissed;
}

class ReadFire extends State<ReadData> {
  static List listID = [];
  DatabaseReference databaseReference = MainHomeState.databaseReference;

  ListTile eachTile(Following following, Text leadingtext1, leadingtext2,
      Text titletext, Text subtitletext) {
    String theID = "";
    theID = leadingtext1.data.toString() + leadingtext2.data.toString();
    theID = theID.replaceAll(RegExp('[^0-9]'), '');
    listID.add(theID);
    print("eachtile = theID = $listID");
    return ListTile(
      leading: Column(
        children: [
          leadingtext1,
          const SizedBox(
            height: 10,
          ),
          leadingtext2,
        ],
      ),
      title: titletext,
      subtitle: subtitletext,
      trailing: IconButton(
        icon: (
                // following.followingListdate.contains(leadingtext1.data) && following.followingListtime.contains(leadingtext2.data) &&
                following.followingListdestination.contains(titletext.data) &&
                    following.followingListsource.contains(subtitletext.data))
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border_outlined),
        onPressed: () {
          if (
              // following.followingListdate.contains(leadingtext1.data) && following.followingListtime.contains(leadingtext2.data) &&
              following.followingListdestination.contains(titletext.data) &&
                  following.followingListsource.contains(subtitletext.data)) {
            following.remove(
                // leadingtext1.data, leadingtext2.data,
                titletext.data,
                subtitletext.data);
          } else {
            following.add(
                // leadingtext1.data, leadingtext2.data,
                titletext.data,
                subtitletext.data);
          }
        },
      ),
    );
  }

  // List<Chat> items = List.of(Data.chats);

  @override
  Widget build(BuildContext context) {
    Following following = Provider.of<Following>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
              child: const Text(
            "Journeys",
            style: TextStyle(fontSize: 20),
          )),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Color(0xFFEAD9DA),
            height: 3.5,
          ),
          const SizedBox(
            height: 20,
          ),
          FirebaseAnimatedList(
              shrinkWrap: true,
              query: databaseReference.child("journeys"),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation animation, int index) {
                try {
                  return Consumer<Following>(
                    builder:
                        (BuildContext context, Following value, Widget? child) {
                      return Dismissible(
                        key: UniqueKey(),
                        secondaryBackground: buildSwipeActionRight(),
                        background: buildSwipeActionLeft(),
                        child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: <Widget>[
                              eachTile(
                                  following,
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)["date"]),
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)["time"]),
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)["destination"]),
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)["source"])),
                            ]),
                        onDismissed: (direction) =>
                            dismissItem(context, index, direction),
                      );
                    },
                  );
                } catch (e) {
                  print(e.toString());
                  return Text(
                      "We Can't show you information disabled by the Administrator");
                }
              }),
        ]),
      ),
    );
  }

  Future<void> dismissItem(
    BuildContext context,
    int index,
    DismissDirection direction,
  ) async {
    // setState(() {
    //   listID.removeAt(index);
    // });

    switch (direction) {
      case DismissDirection.endToStart:
        Snack_bar.showSnackBar(context, 'Journey has been deleted');
        setState(() {
            try {
              databaseReference.child("journeys").child(
                  listID[index].toString()).remove();
              listID.removeAt(index);
            }
            catch (e) {
              print(e.toString());
            }
          });
        break;
      case DismissDirection.startToEnd:
        // EditFire(listID[index].toString(),
        //     databaseReference.child("journeys").child(
        //         listID[index].toString()).child("date").toString(),
        //     databaseReference.child("journeys").child(
        //         listID[index].toString()).child("time").toString(),
        //   databaseReference.child("journeys").child(
        //     listID[index].toString()).child("destination").toString(),
        //     databaseReference.child("journeys").child(
        //         listID[index].toString()).child("source").toString(),
        // );

      var dateref = databaseReference.child("journeys").child(
          listID[index].toString()).child("date");
      var datesnapshot = await dateref.get();
      var datefav = datesnapshot.value.toString();
      var timeref = databaseReference.child("journeys").child(
          listID[index].toString()).child("time");
      var timesnapshot = await timeref.get();
      var timefav = timesnapshot.value.toString();
      var desref = databaseReference.child("journeys").child(
          listID[index].toString()).child("destination");
      var dessnapshot = await desref.get();
      var desfav = dessnapshot.value.toString();
      var srcref = databaseReference.child("journeys").child(
          listID[index].toString()).child("source");
      var srcsnapshot = await srcref.get();
      var srcfav = srcsnapshot.value.toString();
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => EditData(index: index,currentID: listID[index].toString(),olddate: datefav,
            oldtime: timefav,
                des: desfav,
            src: srcfav,)));
        Snack_bar.showSnackBar(context, 'Journey has been edited');
      print(listID[index].toString() + datefav + timefav + desfav + srcfav);
        break;
      default:
        break;

    }
  }

  Widget buildSwipeActionRight() => Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: AlignmentDirectional.centerStart,
        color: Colors.green,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      );
}
// Widget buildListTile() {
//   Following following = Provider.of<Following>(context);
//   return FirebaseAnimatedList(
//       shrinkWrap: true,
//       query: databaseReference.child("journeys"),
//       itemBuilder: (BuildContext context, DataSnapshot snapshot,
//           Animation animation, int index) {
//         try {
//           // var value = Map<String, dynamic>.from(snapshot.value as Map);
//           // var title = value["source"];
//           // print(title);
//           return Consumer<Following>(
//             builder:
//                 (BuildContext context, Following value,
//                 Widget? child) {
//               return Dismissible(
//                   key: UniqueKey(),
//                   secondaryBackground: buildSwipeActionRight(),
//                   background: buildSwipeActionLeft(),
//                   child: ListView(
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       children: <Widget>[
//                         eachTile(
//                             following,
//                             Text(Map<String, dynamic>.from(
//                                 snapshot.value as Map)["date"]),
//                             Text(Map<String, dynamic>.from(
//                                 snapshot.value as Map)["time"]),
//                             Text(Map<String, dynamic>.from(
//                                 snapshot.value as Map)["destination"]),
//                             Text(Map<String, dynamic>.from(
//                                 snapshot.value as Map)["source"])),
//                         getgo(
//                           following,
//                           Text(Map<String, dynamic>.from(
//                               snapshot.value as Map)["date"])
//                               .data
//                               .toString(),
//                           Text(Map<String, dynamic>.from(
//                               snapshot.value as Map)["time"])
//                               .data
//                               .toString(),
//                         )
//                       ]),
//                 onDismissed: (direction) =>
//                     dismissItem(context, index, direction),
//               );
//   (direction) {
// setState(() {
//   try {
//     // items.removeAt(index);
//     databaseReference.child("journeys").child(
//         listID[index].toString()).remove();
//   }
//   catch (e) {
//     print(e.toString());
//   }
// });
// },
// );
//           },
//         );
//       }
//       catch (e) {
//         print(e.toString());
//         return Expanded(child: Text(
//             "We Can't show you information disabled by the Administrator"));
//       }
//     }
// );  }

//------------------------------------------------------------------------------------------
// DatabaseReference databaseReference = MainHomeState.databaseReference;
//
// // List items = getDummyList();
//
// List listID = [];
// // static List getDummyList() {
// //   List list = List.generate(100, (i) {
// //     return "Item ${i + 1}";
// //   });
// //   print(list);
// //   return list;
// // }
// ListTile eachTile(Following following, Text leadingtext1, Text leadingtext2, Text titletext, Text subtitletext) {
//   return ListTile(
//     leading: Column(
//       children: [
//         leadingtext1,
//         SizedBox(
//           height: 10,
//         ),
//         leadingtext2,
//       ],
//     ),
//     title: titletext,
//     subtitle: subtitletext,
//     trailing: IconButton(
//       icon: (
//               // following.followingListdate.contains(leadingtext1.data) && following.followingListtime.contains(leadingtext2.data) &&
//               following.followingListdestination.contains(titletext.data) &&
//                   following.followingListsource.contains(subtitletext.data))
//           ? Icon(Icons.favorite)
//           : Icon(Icons.favorite_border_outlined),
//       onPressed: () {
//         if (
//             // following.followingListdate.contains(leadingtext1.data) && following.followingListtime.contains(leadingtext2.data) &&
//             following.followingListdestination.contains(titletext.data) &&
//                 following.followingListsource.contains(subtitletext.data)) {
//           following.remove(
//               // leadingtext1.data, leadingtext2.data,
//               titletext.data,
//               subtitletext.data);
//         } else {
//           following.add(
//               // leadingtext1.data, leadingtext2.data,
//               titletext.data,
//               subtitletext.data);
//         }
//       },
//     ),
//   );
// }
//
// getgo(Following following, String leadingtext1, String leadingtext2) {
//   String theID = "";
//   theID = leadingtext1 + leadingtext2;
//   theID = theID.replaceAll(RegExp('[^0-9]'), '');
//   print(theID);
//   listID.add(theID);
//   print(listID);
//   return Text("$theID");
// }
//
//
// @override
// Widget build(BuildContext context) {
//   Following following = Provider.of<Following>(context);
//   return Scaffold(
//     body: SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           Center(
//               child: Text(
//             "Journeys",
//             style: TextStyle(fontSize: 20),
//           )),
//           SizedBox(
//             height: 10,
//           ),
//           Divider(
//             color: Color(0xFFEAD9DA),
//             height: 3.5,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           FirebaseAnimatedList(
//               shrinkWrap: true,
//               query: databaseReference.child("journeys"),
//               itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                   Animation animation, int index) {
//                 try {
//                   // var value = Map<String, dynamic>.from(snapshot.value as Map);
//                   // var title = value["source"];
//                   // print(title);
//                   return Consumer<Following>(
//                     builder:
//                         (BuildContext context, Following value,
//                         Widget? child) {
//                       return Dismissible(
//                         key: UniqueKey(),
//                         secondaryBackground: buildSwipeActionRight(),
//                         background: buildSwipeActionLeft(),
//                         child: ListView(
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             children: <Widget>[
//                               eachTile(
//                                   following,
//                                   Text(Map<String, dynamic>.from(
//                                       snapshot.value as Map)["date"]),
//                                   Text(Map<String, dynamic>.from(
//                                       snapshot.value as Map)["time"]),
//                                   Text(Map<String, dynamic>.from(
//                                       snapshot.value as Map)["destination"]),
//                                   Text(Map<String, dynamic>.from(
//                                       snapshot.value as Map)["source"])),
//                               getgo(
//                                 following,
//                                 Text(Map<String, dynamic>.from(
//                                     snapshot.value as Map)["date"])
//                                     .data
//                                     .toString(),
//                                 Text(Map<String, dynamic>.from(
//                                     snapshot.value as Map)["time"])
//                                     .data
//                                     .toString(),
//                               )
//                             ]),
//                         onDismissed: onDissmissed
//                         //   (direction) {
//                         // setState(() {
//                         //   try {
//                         //     // items.removeAt(index);
//                         //     databaseReference.child("journeys").child(
//                         //         listID[index].toString()).remove();
//                         //   }
//                         //   catch (e) {
//                         //     print(e.toString());
//                         //   }
//                         // });
//                         // },
//                       );
//                     },
//                   );
//                 }
//                 catch(e) {
//                   print(e.toString());
//                   return Expanded(child: Text("We Can't show you information disabled by the Administrator"));
//                 }
//               }
//               ),
//           // FirebaseAnimatedList(
//           //     shrinkWrap: true,
//           //     query: databaseReference.child("journeys"),
//           //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
//           //         Animation animation, int index) {
//           //       // var value = Map<String, dynamic>.from(snapshot.value as Map);
//           //       // var title = value["source"];
//           //       // print(title);
//           //       return Consumer<Following>(
//           //         builder:
//           //             (BuildContext context, Following value, Widget? child) {
//           //           return ListView(
//           //               scrollDirection: Axis.vertical,
//           //               shrinkWrap: true,
//           //               children: <Widget>[
//           //
//           //               ]);
//           //         },
//           //       );
//           //     }),
//         ],
//       ),
//     ),
//   );
// }
//
// Widget buildSwipeActionLeft() => Container(
//   alignment: AlignmentDirectional.centerEnd,
//   color: Colors.red,
//   child: Icon(
//     Icons.delete,
//     color: Colors.white,
//   ),
// );
//
// Widget buildSwipeActionRight() => Container(
//   alignment: AlignmentDirectional.centerEnd,
//   color: Colors.green,
//   child: Icon(
//     Icons.edit,
//     color: Colors.white,
//   ),
// );
