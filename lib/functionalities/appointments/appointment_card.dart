import 'package:careapp/functionalities/appointments/appointment_list.dart';
import 'package:careapp/functionalities/appointments/reschedule_card.dart';
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:careapp/screens/home/Counselor/reschedule.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentCard extends StatelessWidget {
  static const titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const textStyle = TextStyle(
    fontSize: 14,
  );

  final String regnumber;
  final String date_booked;
  final String time_booked;
  final String counselee_email;
  final String created_at;
  final String counseleeID;
  final String docID;

  const AppointmentCard({
    Key? key,
    required this.regnumber,
    required this.date_booked,
    required this.time_booked, 
    required this.counselee_email,
    required this.created_at,
    required this.counseleeID, 
    required this.docID
  }) : super(key: key);
  
// Sending email to the counselee informing them on their approval status
String? encodeQueryParameters(Map<String, String>params){
  return params.entries
  .map((MapEntry<String, String>e) =>
  '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeComponent(e.value)}'
  ).join('&');
}
  

  @override
  Widget build(BuildContext context){
    final String uid = counseleeID;
    final docid = docID;
    final email = Uri(
      scheme: 'mailto',
      path: counselee_email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Your Counseling Session was Approved',
        'body': 'Hello $regnumber,\n Your Counseling Session which you booked on $created_at, for\n\n Date: $date_booked \nTime: $time_booked\n has been approved.\n\n You\'ll be contacted by one of our counselors soon.\n\n Kind regards\nBest Counseling App.',
      }),
    );
    Future<void>_sendEmail() async{
      try{
        if(await canLaunchUrl(email)){
          await launchUrl(email);
        }
      }catch(e){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text('Error while launching email sender app'),
          );
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: const Text('Error while launching email sender app')),
        // );
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MainPage();
      },));
    }
    // Function to approve session
    Future approveSession(String docID) async {
      try{
        final approval = await FirebaseFirestore.instance.collection('bookings')
        .doc('$docID').update({
          'approval': "Approved",
          'counseleeID' : FirebaseAuth.instance.currentUser!.uid,
          'time_approved': DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()),
        });
        // const approveSession(docid);
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: const Text('The session has been approved successfully.\n\n Open your email application to send the approval status below!'),
          );
        });
        _sendEmail();
      }
      catch(e){
        // Alerting the user on errors which might arise on the app
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text(e.toString()),
          );
        });
      }
    }
    return SingleChildScrollView(
      child: Column(
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
                        Text('Reg number:', style: titleStyle,),
                        const SizedBox(width: 10,),
                        Text(regnumber),
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
                        Text('Date Booked:', style: titleStyle,),
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
                        Text('Time Booked:', style: titleStyle,),
                        const SizedBox(width: 10,),
                        Text(time_booked),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    // Reading more about the counselee
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CounseleeProfile(counseleeID: this.counseleeID,);
                          
                        },));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Counselee Profile', style: TextStyle(color: Colors.white),),
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
                        MaterialButton(
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: (){
                            print(docid);
                            approveSession(docid);
                          },
                          child: const Text('Approve'),
                        ),
                        const SizedBox(width: 20,),
                        MaterialButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context){
                              return Reschedule(
                              regnumber: this.regnumber, 
                              date_booked: this.date_booked, 
                              time_booked: this.time_booked, 
                              counselee_email: this.counselee_email,
                              created_at: this.created_at,
                              counseleeID: this.counseleeID,
                              docID: docid,
                              );
                            })));
                          },
                          child: const Text('Reschedule'),
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
          )
        ],
      ),
    );
  }
}