import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection('note');

  Future updateUserData(
      String title, String body, DateTime timestamp, int colorVal) async {
    return await noteCollection.doc(uid).set({
      'title': title,
      'body': body,
      'timestamp': timestamp.toString(),
      'color': colorVal
    });
  }
}
