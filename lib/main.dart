import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/model/user_model.dart';
import 'package:quick_notes/screens/wrapper.dart';
import 'package:quick_notes/provider/auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String MY_NOTES_BOX = "my_notes_box";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(MY_NOTES_BOX);
  await Hive.openBox('box_sequence');
  //Hive.box('box_sequence').put('seq', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is te root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quick Notes',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
