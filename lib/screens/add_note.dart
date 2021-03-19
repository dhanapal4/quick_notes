import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_notes/model/note_model.dart';
import 'package:quick_notes/screens/wrapper.dart';

class AddNote extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Note'),
            maxLines: 8,
            controller: noteController,
          ),
          TextButton(
            onPressed: addNoteToCloud,
            child: Text('Add Note'),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.greenAccent)),
          ),
        ],
      ),
    );
  }

  void addNoteToCloud() {
    bool isAdded = false;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('notes');
    NoteModel noteModel = NoteModel();
    noteModel.body = noteController.text;
    noteModel.id = 102;
    noteModel.name = "dhanapal";
    noteModel.timestamp = "03/18/2021";
    noteModel.title = titleController.text;
    noteModel.userId = 1;
    collectionReference
        .add(noteModel.toJson())
        .then((value) => print('value da $value'))
        .whenComplete(() {
      isAdded = true;
      print('Note successfully Added to Firestore');
      Get.offAll(() => Wrapper());
      Get.snackbar('Added', 'Note succesfully added');
    }).catchError((onError) {
      isAdded = false;
      print('On catch error');
      Get.snackbar('Error', 'Unable to add');
    }).onError((error, stackTrace) {
      isAdded = false;
      print('On Error $error - $stackTrace');
      Get.snackbar('Error', 'Unable to add');
    });
  }
}
