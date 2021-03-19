import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quick_notes/provider/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.shade100,
        elevation: 0.0,
        title: Text('Sign in to Quick Notes'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
          ),
          child: Text(
            'Sign in Anon',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            var result = await _auth.signInAnon();
            if (result == null)
              print('Error signin');
            else {
              print('Signed In - $result');
              print('${result.uid}');
              //inspect(result.uid);
            }
          },
        ),
      ),
    );
  }
}
