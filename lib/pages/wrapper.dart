import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/pages/add_note.dart';
import 'package:quick_notes/pages/authenticate/sign_in.dart';
import 'package:quick_notes/pages/logged_in.dart';
import 'package:quick_notes/pages/sign_up.dart';
import 'package:quick_notes/provider/google_sign_in.dart';

class Wrapper extends StatefulWidget {
  final String title;

  Wrapper(this.title);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final user = FirebaseAuth.instance.currentUser;
  bool isLoggedin = false;
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.orange.shade100,
        child: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder<Object>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final provider = Provider.of<GoogleSignInProvider>(context);
                if (provider.isSigningIn) {
                  return buildLoading();
                } else if (snapshot.hasData) {
                  isLoggedin = true;
                  return SignIn();
                  //return LoggedInWidget();
                } else {
                  return SignUpWidget();
                }
              }),
        ),
      );

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
