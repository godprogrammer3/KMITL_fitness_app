import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class UserModel {

  final String uid;
  UserModel({ 
    @required this.uid 
  });

  final CollectionReference userDataCollection = Firestore.instance.collection('userdata');

  Future<void> setUserData(Map<String, dynamic> updateData) async {
    return await userDataCollection.document(uid).setData(updateData);
  }
  Future<void> updateUserData(Map<String, dynamic> updateData) async {
    return await userDataCollection.document(uid).updateData(updateData);
  }
  Future<UserData> getUserData() async {
    final snapshot = await userDataCollection.document(uid).get();
    if( snapshot == null){
      return null;
    }
      return UserData(
        uid:uid,
        firstName:snapshot['firstName'],
        lastName:snapshot['lastName'],
        email:snapshot['email'],
        point: snapshot['point'],
        membershipExpireDate:DateTime.fromMillisecondsSinceEpoch((snapshot['membershipExpireDate'].seconds*1000+snapshot['membershipExpireDate'].nanoseconds/1000000).round()),
        birthYear:snapshot['birthYear'],
        role:snapshot['role'],
        faceId:snapshot['faceId'],
        isHaveYellowCard:snapshot['isHaveYellowCard'],
      );
  }

}