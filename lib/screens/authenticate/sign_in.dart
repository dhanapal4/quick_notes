import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quick_notes/provider/auth.dart';
import 'package:quick_notes/utils/constants.dart';
import 'package:quick_notes/utils/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orangeAccent.shade100,
              elevation: 0.0,
              title: Text('Sign in to Quick Notes'),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) => val.isEmpty
                          ? 'Email should not be blank'
                          : !val.contains('@')
                              ? 'Enter Valid Email ID'
                              : null,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.orange)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter password 6+ chars long'
                          : null,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.orange)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with given credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.orangeAccent.shade200)),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
