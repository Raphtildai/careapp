// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // accessing the user details
  final user = FirebaseAuth.instance.currentUser!;
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Ment Care'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Column(
        children: [
          Text('Signed in as: ' + user.email!),

          FlatButton(
            onPressed: (){
              try{
                FirebaseAuth.instance.signOut();
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Text('You have Logged Out'),

                  );
                });
              }on FirebaseAuthException catch(e){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Text(e.message.toString()),
                  );
                });
              };
              
          }, 
          child: Text('Sign Out'),
          color: Colors.deepPurple,
          ),
        ],
      ),
      // body: Row(
      //   children: [
      //     Expanded(
      //       child: Container(
      //         padding: EdgeInsets.all(30.0),
      //         color: Colors.amber,
      //         child: Text('1'),
      //       ),
      //     ),
      //     Expanded(
      //       child: Container(
      //         padding: EdgeInsets.all(30.0),
      //         color: Colors.black,
      //         child: Text('2'),
      //       ),
      //     ),
      //     Expanded(
      //       child: Container(
      //         padding: EdgeInsets.all(30.0),
      //         color: Colors.red,
      //         child: Text('3'),
      //       ),
      //     ),
      //   ],
      // ),

      // flutter Columns
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         Text('This is the Text'),
      //         Text('This is the second text'),
      //         Text('This is the third'),
      //         RaisedButton(
      //           onPressed: (){},
      //           child: Text('Click Me'),
      //         )
      //       ],
      //     ),
      //     Container(
      //       padding: EdgeInsets.all(23.0),
      //       margin: EdgeInsets.all(50.0),
      //       color: Colors.green,
      //       child: Text('This is a Column'),
      //     ),
      //     Container(
      //       padding: EdgeInsets.all(30.0),
      //       margin: EdgeInsets.all(50.0),
      //       color: Colors.amber,
      //       child: Text('This is a 2nd Column'),
      //     ),
      //     Container(
      //       padding: EdgeInsets.all(40.0),
      //       margin: EdgeInsets.all(50.0),
      //       color: Colors.red,
      //       child: Text('This is a 3rd Column'),
      //     ),
      //   ],
      // ),

      // Flutter Rows 
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Text('Hello World'),
      //     FlatButton(
      //       onPressed: (){},
      //       color: Colors.amber,
      //       child: Text('This is a button'),
      //     ),
      //     Container(
      //       color: Colors.cyan,
      //       padding: EdgeInsets.all(30.0),
      //       child: Text('Inside the container'),
      //     ),
      //   ],
      // ),
      
      // Flutter Containers
      // Container(
      //   padding: EdgeInsets.all(30.0),
      //   margin: EdgeInsets.all(90.0),
      //   color: Colors.grey[400],
      //   child: Text('My Text'),
      // ),
      // Centers contents at the center of the app
      // Center(
      //   child: IconButton(
      //     onPressed: (){},
      //     icon: Icon(
      //       Icons.alternate_email,
      //     ),
      //     color: Colors.amber,
      //   ),
        // Using Buttons with icons
        // RaisedButton.icon(
        //   onPressed: (){},
        //   icon: Icon(
        //     Icons.mail
        //   ),
        //   label: Text('Mail me'),
        //   color: Colors.amber,
        // ),
        // RaisedButton(
        //   onPressed: () {},
        //   child: Text('Click Me'),
        //   color: Colors.red[600],
        // ),
        // FlatButton(
        //   onPressed: () {},
        //   child: Text('Click Me'),
        //   color: Colors.red[600],
        // ),
        // Icon(
        //   Icons.phone,
        //   color: Colors.red[600],
        //   size: 50.0,
        // ),
        //  Text(
        //   'Hello and welcome to Counseling we are delighted that you visited',
        //   style: TextStyle( //allows us to style the text style
        //   fontSize: 15.0,
        //   fontWeight: FontWeight.bold,
        //   letterSpacing: 1.5,
        //   color: Colors.grey[600],
        //   fontFamily: 'Roboto',
        //   ),
        //   ),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Text('More'),
        //   backgroundColor: Colors.red[600],
        // ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Care App Home'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
