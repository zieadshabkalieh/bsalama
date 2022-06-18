import 'package:flutter/material.dart';
class Following extends ChangeNotifier{
  // final List<String> _followingListdate = [];
  // final List<String> _followingListtime = [];
  final List<String> _followingListdestination = [];
  final List<String> _followingListsource = [];
  // List<String> get followingListdate => _followingListdate;
  // List<String> get followingListtime => _followingListtime;
  List<String> get followingListdestination => _followingListdestination;
  List<String> get followingListsource => _followingListsource;

  add(
      // String? date, String? time,
      String? destination, String? source){
    // print("add");
    // print(_followingListdate + _followingListtime + _followingListdestination + _followingListsource);
    // _followingListdate.add(date!);
    // _followingListtime.add(time!);
    _followingListdestination.add(destination!);
    _followingListsource.add(source!);
    // print("add");
    // print(_followingListdate + _followingListtime + _followingListdestination + _followingListsource);
    notifyListeners();
  }
  remove(
      // String? date, String? time,
      String? destination, String? source){
    // print("remove");
    // print(_followingListdate + _followingListtime + _followingListdestination + _followingListsource);
    // _followingListdate.removeWhere((element) => element == date!);
    // _followingListtime.removeWhere((element) => element == time!);
    _followingListdestination.removeWhere((element) => element == destination!);
    _followingListsource.removeWhere((element) => element == source!);
    // print("remove");
    // print(_followingListdate + _followingListtime + _followingListdestination + _followingListsource);
    notifyListeners();
  }
}