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
    UserData result = await userDataCollection.document(uid).get().then((documentSnapshot){
      Map document = documentSnapshot.data;
      return UserData(
        uid:uid,
        firstName:document['firstName'],
        lastName:document['lastName'],
        email:document['email'],
        point: document['point'],
        membershipExpireDate:DateTime.fromMillisecondsSinceEpoch((document['membershipExpireDate'].seconds*1000+document['membershipExpireDate'].nanoseconds/1000000).round()),
        birthYear:document['birthYear'],
        role:document['role'],
        faceId:document['faceId'],
        isHaveYellowCard:document['isHaveYellowCard'],
      );
    });
    return result;
  }
   Future<void> updateMembership(String membershipExpireDate) async {
    return await userDataCollection.document(uid).updateData({
      'membershipExpireDate': membershipExpireDate,
    });
  }

}