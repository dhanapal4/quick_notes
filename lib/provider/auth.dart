import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_notes/model/user_model.dart';

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
  //sign in with anonymous

  //sign in with email & password

  //register with email & password

  //signout

}
