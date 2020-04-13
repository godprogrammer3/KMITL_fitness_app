import 'package:firebase_auth/firebase_auth.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';

import 'package:kmitl_fitness_app/models/models.dart';

class AuthenModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future register(UserData userData, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: userData.email, password: password);
      FirebaseUser user = result.user;
      await UserModel(uid: user.uid).setUserData({
        'firstName': userData.firstName,
        'lastName': userData.lastName,
        'email': userData.email,
        'membershipExpireDate': 'unsubscription',
        'birthYear': 0,
        'role': 'regular_user',
        'faceId': '',
        'isHaveYellowCard': false,
        'point': 0,
      });
      return User(uid: user.uid);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
