import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/main.dart';
import 'package:quick_notes/model/note_model.dart';
import 'package:quick_notes/pages/add_note.dart';
import 'package:quick_notes/provider/google_sign_in.dart';
import 'package:quick_notes/provider/api_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer' as dev;

class LoggedInWidget extends StatefulWidget {
  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  List<NoteModel> notes;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notes = [];
    fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          maxRadius: 20,
          backgroundImage: NetworkImage(user.photoURL),
          backgroundColor: Colors.orange.shade100,
          //child: Text(user.displayName.substring(1, 2)),
        ),
        title: Text(
          'Quick Notes',
          style: TextStyle(color: Colors.orange.shade800),
        ),
        elevation: 0,
        backgroundColor: Colors.orange.shade50,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.orangeAccent,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
      body: _myCloudData(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade800,
        child: Text(
          '+',
          style: TextStyle(fontSize: 35.0),
        ),
        onPressed: () => Get.to(() => AddNote()),
      ),
    );
    // Container(
    //   alignment: Alignment.center,
    //   color: Colors.white,
    //   child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Row(
    //           children: [
    //             Text('Loggedin'),
    //             CircleAvatar(
    //               maxRadius: 25,
    //               backgroundImage: NetworkImage(user.photoURL),
    //             ),
    //             Text(user.displayName),
    //             Text(user.email),
    //             // ElevatedButton(
    //             //   child: Text('Get Countries'),
    //             //   onPressed: () async {
    //             //     List<GetCountries> response = await ApiService().getCountries();
    //             //     Navigator.of(context).push(MaterialPageRoute(
    //             //         builder: (_) => CountriesPage(
    //             //               getCountries: response,
    //             //             )));
    //             //   },
    //             // ),
    //             //_myCloudData(),
    //             // MaterialButton(
    //             //   child: Text('Add Data'),
    //             //   color: Colors.green,
    //             //   onPressed: addData,
    //             // ),
    //             // MaterialButton(
    //             //   child: Text('Fetch Data'),
    //             //   color: Colors.green,
    //             //   onPressed: fetchData,
    //             // ),
    //             // Text(data['name'].toString()),
    //             Expanded(
    //               child: ElevatedButton(
    //                 child: Text('Logout'),
    //                 onPressed: () {
    //                   final provider = Provider.of<GoogleSignInProvider>(
    //                       context,
    //                       listen: false);
    //                   provider.logout();
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //         _myCloudData(),
    //         // (notes != null)
    //         //     ? ListView.builder(
    //         //         itemBuilder: (context, index) {
    //         //           return Expanded(child: Text(notes[index].name));
    //         //         },
    //         //         itemCount: notes.length,
    //         //       )
    //         //     : CircularProgressIndicator()
    //       ]),
    // );
  }

  Widget _myCloudData() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(user.email).snapshots(),
      // .doc('63FkPKrpQ9WVvfPniQnm')
      // .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: snapshot.data.docs
                .map((document) => Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            document['title'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(document['body'])
                        ],
                      ),
                      color: Colors.orange.shade200,
                    ))
                .toList(),
          );
          //}
        }

        return CircularProgressIndicator();
      },
    );
  }

  void addData() {
    Map<String, dynamic> demodata = {
      "id": 101,
      "user_id": 1,
      "name": "dhanapal",
      "title": "Expenses FEB",
      "body": "EB, Seat, Gas etc",
      "timestamp": "02/19/2021"
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("notes");
    collectionReference.add(demodata);
  }

  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("notes");
    collectionReference.snapshots().listen((event) {
      setState(() {
        event.docs.forEach((element) {
          print('Ele - ${element.data()}');
          notes.add(NoteModel.fromJson(element.data()));
        });
        //data = event.docs[0].data();
        //notes.add(NoteModel.fromJson(data));
        //print('data--- $data ');
      });
    });
    //print('d - ${d.length} - $d');
  }
}
