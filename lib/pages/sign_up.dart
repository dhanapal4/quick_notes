import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/provider/google_sign_in.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        child: Center(
          child: ElevatedButton(
            child: Text('Google SignIn'),
            onPressed: () {
              print('pressed');
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.login();
            },
          ),
        ),
      );
}
