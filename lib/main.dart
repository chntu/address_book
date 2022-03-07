import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAPrGnQbL2ZmLCLFCDMPsdXCGKYakTMOoU",
          authDomain: "address-book-8cfbe.firebaseapp.com",
          projectId: "address-book-8cfbe",
          storageBucket: "address-book-8cfbe.appspot.com",
          messagingSenderId: "1035089139408",
          appId: "1:1035089139408:web:dd2acb23377ee73ec5b0d5"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MainScreen(),
    );
  }
}
