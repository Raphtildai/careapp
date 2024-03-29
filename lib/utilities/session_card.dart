import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:careapp/screens/home/Counselor/approve_session.dart';
import 'package:careapp/screens/home/Counselor/counselor_profile.dart';
import 'package:careapp/screens/home/Counselee/reschedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionCard extends StatelessWidget {

  // Parameters to be passed to Counselee card
  final String date_booked;
  final String time_booked;
  final String status;
  final String counselorID;
  final String counselor_email;
  final String date_created;

  const SessionCard({
    super.key, 
    required this.date_booked,
    required this.time_booked,
    required this.status,
    required this.counselorID,
    required this.counselor_email,
    required this.date_created,
  });

  @override
  Widget build(BuildContext context){
    
  
  //Function to launch more about counseling
  final Uri url = Uri.parse('https://www.counseling.org/aca-community/learn-about-counseling/what-is-counseling');


  Future<void> _launchUrl() async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

    final String uid = counselorID;
    final String approval_status = status;
    // DateTime date = time_booked;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,0,0,0),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: [
            // Date booked
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(width: 5,),
                  const Text('Date:'),
                  const SizedBox(width: 5,),
                  Expanded(child: Text(date_booked)),
                ],
              ),
            ),
            const SizedBox(height: 5,),

            //Time Booked
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.timelapse),
                  const SizedBox(width: 5,),
                  const Text('Time:'),
                  const SizedBox(width: 5,),
                  Expanded(child: Text(time_booked)),
                ],
              ),
            ),
            const SizedBox(height: 5,),

            // Status of the approval
            Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  const Text('Approval Status:'),
                  const SizedBox(width: 5,),
                  Text(status),
                ],
              ),
            ),
            const SizedBox(height: 5,),
      
            //Read more button
            status == "Approved" ? GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CounselorProfile(counselorID: this.counselorID,);
                  
                },));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.deepPurple,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Check Counselor Profile', style: TextStyle(color: Colors.white),),
                ),
              ),
            )
            : Text(''),

            // Button to reschedule the session
            const Divider(
              // height: 10,
              thickness: 1.0,
              color: Colors.white,
            ),

            status == "Pending" ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20,),
                MaterialButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context){
                      return Reschedule(
                      date_booked: this.date_booked, 
                      time_booked: this.time_booked,
                      counselor_email: counselor_email, 
                      created_at: date_created, 
                      docID: FirebaseAuth.instance.currentUser!.uid,
                      );
                    })));
                  },
                  child: const Text('Reschedule'),
                ),
              ],
            )
            : Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(
                child: const Text('Read more about counseling'),
                onPressed: () {
                  _launchUrl();
                },
              )
            ],),
          ],
        ),
      ),
    );
  }
}