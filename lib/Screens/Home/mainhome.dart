import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'Model/following.dart';
import 'package:bsalama/Screens/Home/readdata.dart';
import 'package:bsalama/Screens/Home/writedata.dart';
import 'package:flutter/material.dart';
import 'favorite.dart';
import 'home.dart';

class MainHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainHomeState();
}

class MainHomeState extends State<MainHome> {
  int currentIndex = 0;
  static late final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Bissalama");

  final screens = [
    Home(),
    Favorite(),
    // Column(children: const [ Text("data")]),
    ReadData(),
    // // CircleWidget()
    WriteData()



  ];

  final colors = [
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Following(),
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          // showSelectedLabels: true,
          selectedItemColor: Colors.white,
          backgroundColor: colors[currentIndex],
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          iconSize: 20,
          selectedFontSize: 10,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            const BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: 'Home',
                backgroundColor: Colors.blue),
            const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'Favorite',
                backgroundColor: Colors.red),
            const BottomNavigationBarItem(
                icon: const Icon(Icons.explore_outlined),
                label: 'Show Journeys',
                backgroundColor: Colors.blue),
            const BottomNavigationBarItem(
                icon: Icon(Icons.airplanemode_active),
                label: 'Add Journey',
                backgroundColor: Colors.green),
          ],
        ),
      ),
    );
  }
}
