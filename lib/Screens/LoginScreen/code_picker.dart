import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
class CodePicker extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyCodePicker();


}

class MyCodePicker extends State<CodePicker>{
  static String extention ="+963";
  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Container(
          child: CountryCodePicker(
            onChanged: (e) => extention=e.toString(),
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: '+963',
            favorite: ['+963'],
            countryFilter: [
              "SY",
              "IT",
              "FR",
              "af",
              "am",
              "ar",
              "az",
              "be",
              "bg",
              "bn",
              "bs",
              "ca",
              "cs",
              "da",
              "de",
              "el",
              "en",
              "es",
              "et",
              "fa",
              "fi",
              "fr",
              "gl",
              "ha",
              "he",
              "hi",
              "hr",
              "hu",
              "hy",
              "id",
              "is",
              "it",
              "ja",
              "ka",
              "kk",
              "km",
              "ko",
              "ku",
              "ky",
              "lt",
              "lv",
              "mk",
              "ml",
              "mn",
              "ms",
              "nb",
              "nl",
              "nn",
              "no",
              "pl",
              "ps",
              "pt",
              "ro",
              "ru",
              "sd",
              "sk",
              "sl",
              "so",
              "sq",
              "sr",
              "sv",
              "ta",
              "tg",
              "th",
              "tk",
              "tr",
              "tt",
              "uk",
              "ug",
              "ur",
              "uz",
              "vi",
              "zh"
            ],
            showFlagDialog: true,
          ),
        ),
      );
  }
}