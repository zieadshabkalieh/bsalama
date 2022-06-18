import 'package:bsalama/Screens/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: "AAAA8KlFvlo:APA91bGO1tWQNf-4pleKKEPk2jgkSr3VCiM1TswmiflqfhUDsDItIdTC5n3YE5gWLMQQ4zrnvgXfM3tFwd3F5fn65OaQHedr2ERKDUjxvrPKSr9etQikvduek7UwGjfU32ZGxAnVERVe",
      //   appId: "1:1033632071258:web:1cc5103aee28855d832263",
      //   messagingSenderId: "1033632071258",
      //   projectId: "bissalama-ce5b1",
      // ),
      );
  runApp(FirstClass());
}
class FirstClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SplashScreen()
      );
  }
}