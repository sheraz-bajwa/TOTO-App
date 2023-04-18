import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Add_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:todoapp/signin.dart';
import 'package:todoapp/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  final Firestore = FirebaseFirestore.instance.collection('user').snapshots();
  final ref = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      //drawer: Drawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('TODO List'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                    ).onError((error, stackTrace) {
                      Utils().toastmessage(error.toString());
                    }));
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: Firestore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Some Error ');
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image(
                                    image: AssetImage('assets/to-do-list.png'),
                                    height: 50,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        " ${snapshot.data!.docs[index]['title'].toString()}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                          "${snapshot.data!.docs[index]['description'].toString()}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .doc(snapshot.data!.docs[index]['id']
                                            .toString())
                                        .delete();
                                  },
                                  child: Image(
                                    image: AssetImage('assets/delete.png'),
                                    height: 40,
                                  ),
                                ),

                                /*ListTile(
                                  leading: Image.asset('assets/to-do-list.png'),
                                  title: Text(
                                    "Task: ${snapshot.data!.docs[index]['title'].toString()}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      "Description :${snapshot.data!.docs[index]['description'].toString()}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),*/
                                //Image(image: AssetImage('assets/delete.png')
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPost()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
