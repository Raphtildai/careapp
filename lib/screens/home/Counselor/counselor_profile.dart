// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class CounselorProfile extends StatefulWidget {
  final String counselorID;
  String imageUrl = "";

  CounselorProfile({super.key, required this.counselorID});

  @override
  State<CounselorProfile> createState() => _CounselorProfileState();
}

class _CounselorProfileState extends State<CounselorProfile> {
  // Function to get the user image
  Future getImage(String userId) async {
    try {
      Reference ref =
          await FirebaseStorage.instance.ref().child("${widget.counselorID}.jpg");
      if (ref != true) {
        // Getting the image url
        ref.getDownloadURL().then((value) {
          setState(() {
            widget.imageUrl = value;
          });
        });
      } else {
        return null;
      }
    } catch (e) {
      return ErrorPage('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getImage(widget.counselorID);
  }

  @override
  Widget build(BuildContext context) {
    // Retrieving the record of the specified counselor
    CollectionReference counselor =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: counselor.doc(widget.counselorID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // Error handling conditions
        if (snapshot.hasError) {
          Navigator.of(context).pop();
          const AlertDialog(
            content: Text('Something went Wrong'),
          );
          return MainPage();
          // return Center(child: Text('Something went Wrong'));
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          Navigator.of(context).pop();
          const AlertDialog(
            content: Text('The counselor Record does not exist'),
          );
          // return MainPage();
          // const AlertDialog(
          //   content: Text(''),
          // );
          // return Center(child: Text('The counselor Record does not exist'),);
        }

        // Outputting the data to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          // Encoding for SMS
          final Uri smsUri = Uri(
            scheme: 'sms',
            path: '+254${data['pnumber']}',
          );

          Future<void> _message() async {
            try {
              if (await canLaunchUrl(smsUri)) {
                await launchUrl(smsUri);
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Some error occurred'),
                ),
              );
            }
          }

          // Encoding phone calls
          final Uri callUri =
              Uri(scheme: 'tel', path: '+254${data['pnumber']}');
          Future<void> _call() async {
            try {
              if (await canLaunchUrl(callUri)) {
                await launchUrl(callUri);
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Some error occurred'),
                ),
              );
            }
          }

          // Encoding Emails
          final mailUri = Uri(
            scheme: 'mailto',
            path: '${data['email']}',
          );
          Future<void> _email() async {
            try {
              if (await canLaunchUrl(mailUri)) {
                await launchUrl(mailUri);
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Some error occurred'),
                ),
              );
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                  '${data['firstname']} ' '${data['lastname']}\'s Profile '),
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          // height: MediaQuery.of(context).size.height - 200,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              // A picture at the left
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: widget.imageUrl != ""
                                    ? Image.network(
                                        widget.imageUrl,
                                        // height: 100,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.black,
                                      ),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              // A message at the Right
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Name: ${data['firstname']} '
                                    '${data['lastname']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                      Text(
                                        'Specialization:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${data['profession']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[100],
                          ),
                          // height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '${data['about']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[100],
                          ),
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  'Qualifications',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Counselor ID:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${data['counselorID']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[100],
                          ),
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  'Quotes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '"Emotional wellbeing is just as important to us as Breathing is!"',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'BetterLYF',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[100],
                          ),
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _message();
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.message,
                                      ),
                                      Text('Message Me'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _call();
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.call,
                                      ),
                                      Text('Call Me'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () => _email(),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                      ),
                                      Text('Email Me'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        // Return loading to the user
        return Scaffold(body: Center(child: CircularProgressIndicator()));
        // return Center(child: );
      },
    );
  }
}
