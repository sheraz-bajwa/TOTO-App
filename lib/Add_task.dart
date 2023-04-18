import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todoapp/button.dart';
import 'package:todoapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _FKey = GlobalKey<FormState>();
  final postcontroler = TextEditingController();
  final descriptioncontroler = TextEditingController();
  // ignore: non_constant_identifier_names
  //final Firebaseuser = auth.currentUser;
  bool loading = false;
  final Firestore = FirebaseFirestore.instance.collection('user');

  addposttofirestoremeethood() async {
    var time = DateTime.now();
    String id = DateTime.now().millisecond.toString();
    Firestore.doc(id).set({
      'title': postcontroler.text.toString(),
      'description': descriptioncontroler.text.toString(),
      'id': id,
      'time': time.toString()
    }).then((value) {
      Utils().toastmessage('Data Added');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastmessage(error.toString());
    });
  }

  addtasktofirestore() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser;
    String uid = user!.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('task')
        .doc(uid)
        .collection('mytask')
        .doc(time.toString())
        .set({
      'title': postcontroler.text,
      'description': descriptioncontroler.text,
      'time': time.toString()
    }).then((value) {
      Utils().toastmessage('Data Added');
    }).onError((error, stackTrace) {
      Utils().toastmessage(error.toString());
    });
    //Fluttertoast.showToast(msg: 'post added');
  }

  //final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('New Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _FKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: postcontroler,
                //obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Add task',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Add task',
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Add Task';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: descriptioncontroler,
                //obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Add Description',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Description',
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Add Description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Round(
                  title: 'Add Task',
                  ontap: () {
                    if (_FKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      addposttofirestoremeethood();
                    }

                    // String id = DateTime.now().millisecond.toString();
                    //addtasktofirestore();
                    /*databaseRef.child(id).set({
                      'title': postcontroler.text.toString(),
                      'id': id,
                    }).then((value) {
                      Utils().toastmessage('Post Added');
                    }).onError((error, stackTrace) {
                      Utils().toastmessage(error.toString());
                    });*/
                  })
            ],
          ),
        ),
      ),
    );
  }
}
