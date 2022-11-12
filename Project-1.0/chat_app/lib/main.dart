import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';

//The void main fn is called first and it initiates fn runApp on which we pass an object of Widget class MyApp
void main() => runApp(MyApp());

// A class becomes a widget when it extends state_ful/less Widget
// and it returns a Widget returning  method build with argument Buildcontext ctx
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat_App',

            //Setting up the basic themes
            theme: ThemeData(
              primarySwatch: Colors.pink,
              backgroundColor: Colors.pink,
              // ignore: deprecated_member_use
              accentColor: Colors.deepPurple,
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.pink,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            //MyApp Widget directs to the Authscreen or the ChatScreen depending to the data it recieves from the backend about Authstate
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, usersnapshot) {
                if (usersnapshot.hasData) {
                  return Chat();
                }
                return Auth_Screen();
              },
            ),
          );
        });
  }
}
