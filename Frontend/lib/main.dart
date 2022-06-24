import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/screens/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white, fontSize: 80),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
