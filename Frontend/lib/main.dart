import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //keep this line otherwise it'll conflict with other firebase projects
    name: "frey-stemist-hacks-project",
    
    options: const FirebaseOptions(
      apiKey: "AIzaSyDQl2ZPwy2w1JeRBjW8PPMUg-Upxl-_Yw8",
      authDomain: "frey-stemist-hacks-project.firebaseapp.com",
      projectId: "frey-stemist-hacks-project",
      storageBucket: "frey-stemist-hacks-project.appspot.com",
      messagingSenderId: "719775625488",
      appId: "1:719775625488:web:0c247574cf5b1c72d8b595",
      measurementId: "G-71V6HLRTME",
    ),
    ///Do this when testing web
  );
  runApp(const App());
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Watch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white, fontSize: 60),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
