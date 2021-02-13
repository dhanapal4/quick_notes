import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/model/message.dart';
import 'package:quick_notes/pages/logged_in.dart';
import 'package:quick_notes/pages/sign_up.dart';
import 'package:quick_notes/provider/google_sign_in.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // final List<Message> messages = [];

  // @override
  // void initState() {
  //   dev.log('Inside InitState', name: 'HomePage');
  //   super.initState();

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> msg) async {
  //       print('onMessage - $msg');
  //       final notification = msg['notification'];
  //       setState(() {
  //         messages.add(Message(title: notification));
  //       });
  //     },
  //     onLaunch: (Map<String, dynamic> msg) async {
  //       print('onLaunch - $msg');
  //     },
  //     onResume: (Map<String, dynamic> msg) async {
  //       print('onResume - $msg');
  //     },
  //   );

  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(sound: true, badge: true, alert: true));
  // }

  // @override
  // Widget build(BuildContext context) => ListView(
  //       children: messages.map(buildMessage).toList(),
  //     );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Quick Notes'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder<Object>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final provider = Provider.of<GoogleSignInProvider>(context);
                if (provider.isSigningIn) {
                  return buildLoading();
                } else if (snapshot.hasData) {
                  return LoggedInWidget();
                } else {
                  return SignUpWidget();
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text(
            '+',
            style: TextStyle(fontSize: 35.0),
          ),
        ),
      );

  Widget buildLoading() => Center(child: CircularProgressIndicator());

  Widget buildMessage(Message e) => ListTile(
        title: Text(e.title),
        subtitle: Text(e.body),
      );
}
