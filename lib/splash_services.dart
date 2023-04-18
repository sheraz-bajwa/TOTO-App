import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Add_task.dart';
import 'package:todoapp/home.dart';
import 'package:todoapp/signin.dart';

class splashservices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 7),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              ));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signin()),
      );
    }
  }
}
