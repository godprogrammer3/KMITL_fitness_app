import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future<User> register(UserData userData, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: userData.email, password: password);
      FirebaseUser user = result.user;
      await UserModel(uid: user.uid).setUserData({
        'firstName': userData.firstName,
        'lastName': userData.lastName,
        'email': userData.email,
        'membershipExpireDate': DateTime.now(),
        'birthDate': '',
        'role': 'regular_user',
        'faceId': '',
        'isHaveYellowCard': false,
        'point': 0,
        'phoneNumber': '',
        'type': userData.type,
        'discount': -1.0,
      });
      return User(uid: user.uid);
    } catch (error) {
      if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        throw Exception('ERROR_EMAIL_ALREADY_IN_USE');
      }
      return null;
    }
  }

  // sign out
  Future<int> signOut() async {
    try {
      await _auth.signOut();
      return 0;
    } catch (error) {
      print(error.toString());
      return -1;
    }
  }

  Future<int> loginWithFacebook() async {
    var facebookLogin = FacebookLogin();
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      try {
        await _auth.signInWithCredential(FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token));
      } catch (error) {
        if (error.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
          var graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${result.accessToken.token}');
          Map<String, dynamic> profile = json.decode(graphResponse.body);
          var email = profile["email"];

          final signInMethods = await FirebaseAuth.instance
              .fetchSignInMethodsForEmail(email: email);
        }
      }

      return 0;
    } else {
      return -1;
    }
  }

  Future<int> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly'
      ]);
      GoogleSignInAccount googleSignInAccount;
      try {
        googleSignInAccount = await googleSignIn.signIn();
      } catch (error) {
        print(error);
        return -1;
      }

      final googleAuth = await googleSignInAccount.authentication;
      final googleAuthCred = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await _auth.signInWithCredential(googleAuthCred);
      final user = await _auth.currentUser();
      var graphResponse = await http.get(
          'https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token=${googleAuth.accessToken}');
      Map<String, dynamic> profile = json.decode(graphResponse.body);
      final snapshot = await Firestore.instance
          .collection('userdata')
          .document(user.uid)
          .get();
      if (!snapshot.exists) {
        await UserModel(uid: user.uid).setUserData({
          'firstName': profile['given_name'] ?? '',
          'lastName': profile['family_name_name'] ?? '',
          'email': googleSignInAccount.email,
          'membershipExpireDate': DateTime.now(),
          'birthDate': '',
          'role': 'regular_user',
          'faceId': '',
          'isHaveYellowCard': false,
          'point': 0,
          'phoneNumber': '',
          'type': 'google',
          'discount': -1.0,
        });
      }
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    return _auth.currentUser();
  }
}
