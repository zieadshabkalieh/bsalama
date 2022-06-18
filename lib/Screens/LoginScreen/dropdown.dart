import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => IniState();

}

class IniState extends State<Dropdown>{
  String dropdownValue = 'Agency';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Color(0xff000000)),
      underline: Container(
        height: 2,
        width: 50,
        color: Color(0xffF2861E),
      ),
      onChanged: (String? newValue) {
    setState(() {
    dropdownValue = newValue!;
    });},
      items: <String>['Agency', 'Clerk', 'Passenger']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}