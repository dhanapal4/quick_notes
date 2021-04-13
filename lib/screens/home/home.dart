import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_notes/provider/auth.dart';
import 'package:quick_notes/provider/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_notes/screens/add_note.dart';
import 'package:quick_notes/screens/home/notes_list.dart';
import 'package:quick_notes/screens/home/show_notes.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().notes,
      child: Scaffold(

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
        body: ShowNotes(),
        drawer: Drawer(
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children:  [
    const Text('This is the Drawer'),
    ElevatedButton(
    onPressed: (){},
    child: const Text('Close Drawer'),
    ),
    ],
    ),
    ),),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            Get.to(() => AddNote());
          },
        ),
      ),
    );
  }
}
