import 'package:buzzmate/Screens/homeScreen.dart';
import 'package:buzzmate/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  // Fixed spelling
  Authenticate({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return HomeScreen();
    } else {
      return Login_Screen(); // Changed to camel case
    }
  }
}
