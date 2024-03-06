import 'package:flutter/material.dart';
import 'package:flutter_project/db_con/db_conn.dart';
import 'package:flutter_project/pages/home2.dart';
import 'package:flutter_project/pages/home3.dart';
import 'package:flutter_project/pages/locs.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService api = ApiService();
    return Scaffold(
      body:FutureBuilder<bool>(
  future: api.doesUrlExist(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // While waiting for the future to complete, show a loading indicator or any other widget
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      // If there's an error, show an error message or handle it accordingly
      return Text('Error: ${snapshot.error}');
    } else {
      // If the future has completed successfully
      final idExists = snapshot.data!;
      if (idExists) {
        return HorizontalSlidingDemo ();
      } else {
        return Login();
      }
    }
  },
)
      
    );
  }
}