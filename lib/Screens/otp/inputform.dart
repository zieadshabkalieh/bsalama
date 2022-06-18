import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inputform extends StatefulWidget {
  final ValueChanged<String> onHoleCodeChanged;

  const Inputform({
    Key? key,
    required this.onHoleCodeChanged,
  }) : super(key: key);
  @override
  State<Inputform> createState() => InputformState();
}

class InputformState extends State<Inputform> {

  List<String> code = ["","","","","",""];
  String holeCode = "default";

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 68,
            width: 55,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  code[0] = value;
                  holeCode = code[0] + code[1] + code[2] + code[3] + code[4] + code[5];
                  widget.onHoleCodeChanged(holeCode);
                });
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (pin1) {},
              decoration: const InputDecoration(hintText: "0"),
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 55,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  setState(() {
                    code[1] = value;
                    holeCode = code[0] + code[1] + code[2] + code[3] + code[4] + code[5];
                    widget.onHoleCodeChanged(holeCode);
                  });
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (pin1) {},
              decoration: const InputDecoration(hintText: "0"),
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),SizedBox(
            height: 68,
            width: 55,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  setState(() {
                    code[2] = value;
                    holeCode = code[0] + code[1] + code[2] + code[3] + code[4] + code[5];
                    widget.onHoleCodeChanged(holeCode);
                  });
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (pin1) {},
              decoration: const InputDecoration(hintText: "0"),
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),SizedBox(
            height: 68,
            width: 55,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  setState(() {
                    code[3] = value;
                    holeCode = code[0] + code[1] + code[2] + code[3] + code[4] + code[5];
                    widget.onHoleCodeChanged(holeCode);
                  });
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (pin1) {},
              decoration: const InputDecoration(hintText: "0"),
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),SizedBox(
            height: 68,
            width: 55,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  setState(() {
                    code[4] = value;
                    holeCode = code[0] + code[1] + code[2] + code[3] + code[4] + code[5];
                    widget.onHoleCodeChanged(holeCode);
                  });
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (pin1) {},
              decoration: const InputDecoration(hintText: "0"),
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),SizedBox(
            height: 68,
            width: 55,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  setState(() {
                    code[5] = value;
                    holeCode = code[0] + code[1] + code[2] + code[3] + code[4] + code[5];
                    widget.onHoleCodeChanged(holeCode);
                  });
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (pin1) {},
              decoration: const InputDecoration(hintText: "0"),
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),

        ],
      ),
    );
  }
}