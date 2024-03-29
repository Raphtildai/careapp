// import 'dart:html';

// ignore_for_file: non_constant_identifier_names

import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CounselingSessionCard extends StatelessWidget {
  static const titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const textStyle = TextStyle(
    fontSize: 14,
  );

  final String date_booked;
  final String time_booked;
  final String counselee_email;
  final String counseleeID;
  final String docID;

  const CounselingSessionCard({
    Key? key,
    required this.date_booked,
    required this.time_booked, 
    required this.counselee_email,
    required this.counseleeID, 
    required this.docID
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    // Function to launch google meet
    final Uri meet = Uri(
      scheme: 'https',
      // host: 'meet.google.com',
      path: 'meet.google.com'
    );
    // String meet = 'https://meet.google.com';
    Future meeting() async{
      try{
        if(await canLaunchUrl(meet)){
          await launchUrl(meet);
        }
      }catch (e){
        return ErrorPage('Some error occurred: $e');
      }
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color:Colors.deepPurple[200], 
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // Counselee's Reg number
                  const Divider(
                    // height: 10,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Counselee Email:', style: titleStyle,),
                      const SizedBox(width: 10,),
                      Expanded(child: Text(counselee_email)),
                    ],
                  ),
                  const SizedBox(height: 10,),

                  // Date booked
                  
                  const Divider(
                    // height: 10,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Date Booked:', style: titleStyle,),
                      const SizedBox(width: 10,),
                      Text(date_booked),
                    ],
                  ),
                  const SizedBox(height: 10,),

                  // Time booked
                  const Divider(
                    // height: 10,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Time Booked:', style: titleStyle,),
                      const SizedBox(width: 10,),
                      Text(time_booked),
                    ],
                  ),
                  const SizedBox(height: 10,),

                  // Reading more about the counselee
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CounseleeProfile(counseleeID: counseleeID,);
                      },));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.deepPurple,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Check Counselee Profile', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10,),

                  // Approval Buttons
                  const Divider(
                    // height: 10,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20,),
                      MaterialButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: (){
                          meeting();
                          // return AuthPage();
                        },
                        child: const Text('Launch Meeting'),
                      ),
                    ],
                  ),
                  const Divider(
                    // height: 10,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}