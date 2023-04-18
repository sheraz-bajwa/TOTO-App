import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todoapp/button.dart';
import 'package:todoapp/signin.dart';
import 'package:todoapp/utils.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  final _FormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    PasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'SIGNUP',
                          style: TextStyle(
                              // color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Create An Account',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Color.fromARGB(255, 12, 57, 124),
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                            key: _FormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                      fillColor: Colors.grey.shade200,
                                      filled: true),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: PasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                      fillColor: Colors.grey.shade200,
                                      filled: true),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Password';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Round(
                          loading: loading,
                          title: 'SignUP',
                          ontap: () {
                            if (_FormKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              _auth
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text.toString(),
                                      password:
                                          PasswordController.text.toString())
                                  .then((value) {
                                Utils().toastmessage('Account created');
                                setState(() {
                                  loading = false;
                                });
                              }).onError((error, stackTrace) {
                                Utils().toastmessage(error.toString());
                                setState(() {
                                  loading = false;
                                });
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'or login with',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SignInButton(
                              Buttons.Apple,
                              mini: true,
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SignInButton(
                              Buttons.Facebook,
                              mini: true,
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SignInButton(
                              Buttons.Twitter,
                              mini: true,
                              onPressed: () {},
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Already have an account? "),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Signin()),
                                  );
                                },
                                child: Text('login Here'))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
