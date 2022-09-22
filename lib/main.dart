import 'package:flutter/material.dart';
import 'package:posproject/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login.dart';
import 'constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pos',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        // scaffoldBackgroundColor:Colors.teal
      ),
      home:  const LoginScreen(),
    );
  }
}

