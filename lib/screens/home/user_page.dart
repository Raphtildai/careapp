// ignore_for_file: camel_case_types, avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'package:careapp/services/get_counselee_data.dart';
import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User_page extends StatefulWidget {
  const User_page({Key? key}) : super(key: key);

  @override
  State<User_page> createState() => Creating();
}

class Creating extends State<User_page> {
  // accessing the user details
  final user = FirebaseAuth.instance.currentUser!;

  // creating a list of document IDs
  List <String> docIDs = [];

  // Creating function to retrieve the documents
  Future getdocIDs() async {

    await FirebaseFirestore.instance.collection('users').where('role', isEqualTo: "counselee").get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
      }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Counselee'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getdocIDs(),
              builder: ((context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: NeuBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            GetCounseleeData(documentIds: docIDs[index])
                          ],
                        ),
                      )
                    ),
                  );
                });
              }),
            )
          )
        ],
      ),
    );
  }
}