import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_notes/model/note_model.dart';

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

  //notes list from snapshot
  List<NoteModel> _noteListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return NoteModel(
        body: doc.data()['body'] ?? '',
        id: doc.data()['id'] ?? '',
        name: doc.data()['name'] ?? '',
        timestamp: doc.data()['timestamp'] ?? '',
        title: doc.data()['title'] ?? '',
      );
    });
  }

  Stream<QuerySnapshot> get notes {
    return noteCollection.snapshots();
  }
}
