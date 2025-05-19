import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBWHChEqH3Wp7FmQDLm9FySWCliNH7OnGQ",
      authDomain: "cinepedia-firebase-2b31c.firebaseapp.com",
      projectId: "cinepedia-firebase-2b31c",
      storageBucket: "cinepedia-firebase-2b31c.appspot.com",
      messagingSenderId: "201516470698",
      appId: "1:201516470698:web:7153bd7e4fa24b3394dbd3",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinePedia',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
