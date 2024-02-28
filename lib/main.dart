import 'package:flutter/material.dart';
import 'package:flutter_project/pages/home.dart';
import 'package:flutter_project/pages/home2.dart';
import 'package:flutter_project/pages/home3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}


