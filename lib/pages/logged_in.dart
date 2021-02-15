import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/main.dart';
import 'package:quick_notes/model/get_countries.dart';
import 'package:quick_notes/pages/countries_page.dart';
import 'package:quick_notes/provider/google_sign_in.dart';
import 'package:quick_notes/provider/api_provider.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      alignment: Alignment.center,
      color: Colors.lightBlue,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loggedin'),
            CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage(user.photoURL),
            ),
            Text(user.displayName),
            Text(user.email),
            ElevatedButton(
              child: Text('Get Countries'),
              onPressed: () async {
                List<GetCountries> response = await ApiService().getCountries();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CountriesPage(
                          getCountries: response,
                        )));
              },
            ),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
          ]),
    );
  }
}
