import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String membership;
  UserData({this.firstName, this.lastName, this.email,this.uid,this.membership});
}