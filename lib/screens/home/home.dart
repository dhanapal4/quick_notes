import 'package:flutter/material.dart';
import 'package:quick_notes/provider/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      appBar: AppBar(
        title: Text('Quick Notes'),
        backgroundColor: Colors.orangeAccent.shade100,
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(
              Icons.person,
              color: Colors.orange,
            ),
            label: Text(
              'Sign out',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
