import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';

// Firebase Configuration
const firebaseConfig = {
  "apiKey": "AIzaSyBWHChEqH3Wp7FmQDLm9FySWCliNH7OnGQ",
  "authDomain": "cinepedia-firebase-2b31c.firebaseapp.com",
  "projectId": "cinepedia-firebase-2b31c",
  "storageBucket": "cinepedia-firebase-2b31c.firebasestorage.app",
  "messagingSenderId": "201516470698",
  "appId": "1:201516470698:web:7153bd7e4fa24b3394dbd3",
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa Firebase con la configuración
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: firebaseConfig['apiKey']!,
      authDomain: firebaseConfig['authDomain']!,
      projectId: firebaseConfig['projectId']!,
      storageBucket: firebaseConfig['storageBucket']!,
      messagingSenderId: firebaseConfig['messagingSenderId']!,
      appId: firebaseConfig['appId']!,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinePedia',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
