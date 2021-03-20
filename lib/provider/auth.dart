import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_notes/model/user_model.dart';
import 'package:quick_notes/provider/database.dart';

//Authentication for Email Sign-In and Anonymous authentication from Firebase
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creating user object based on Firebase user

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<UserModel> get user => _auth
      .authStateChanges()
      //.map((User user) => _userFromFirebaseUser(user));//same as below
      .map(_userFromFirebaseUser);

  //sign in with anonymous
  Future<UserModel> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
      //return user.uid;
    } catch (e) {
      print('SignInAnon CATCH Block - $e');
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('ERROR IN CATCH BOCK REGISTER WITH EMAIL & PASSWORD - $e');
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //create new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData(
          'Welcome to quick note',
          'Start taking note quickly',
          DateTime.now(),
          100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print('ERROR IN CATCH BOCK REGISTER WITH EMAIL & PASSWORD - $e');
      return null;
    }
  }

  //signout

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('In Signout CATCH Block - $e');
      return null;
    }
  }
}
