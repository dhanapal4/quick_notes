import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/model/user_model.dart';
import 'package:quick_notes/screens/authenticate/authenticate.dart';
import 'package:quick_notes/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    //return either Authenticate or Home .
    if (user != null)
      return Home();
    else
      return Authenticate();
    //return Authenticate();
  }

  // Container(
  //     color: Colors.orange.shade100,
  //     child: ChangeNotifierProvider(
  //       create: (context) => GoogleSignInProvider(),
  //       child: StreamBuilder<Object>(
  //           stream: FirebaseAuth.instance.authStateChanges(),
  //           builder: (context, snapshot) {
  //             final provider = Provider.of<GoogleSignInProvider>(context);
  //             if (provider.isSigningIn) {
  //               return buildLoading();
  //             } else if (snapshot.hasData) {
  //               isLoggedin = true;
  //               return SignIn();
  //               //return LoggedInWidget();
  //             } else {
  //               return SignUpWidget();
  //             }
  //           }),
  //     ),
  //   );

  //Widget buildLoading() => Center(child: CircularProgressIndicator());
}
