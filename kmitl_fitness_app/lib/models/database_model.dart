import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class DatabaseModel {

  final String uid;
  DatabaseModel({ 
    @required this.uid 
  });

  // collection reference
  final CollectionReference kmitlFitnessCollection = Firestore.instance.collection('UserData');

  Future<void> updateUserData(UserData userData) async {
    return await kmitlFitnessCollection.document(uid).setData({
      'firstName': userData.firstName,
      'lastName': userData.lastName,
      'email': userData.email,
      'point': userData.point,
      'membershipExpireDate': userData.membershipExpireDate,
      'birthYear':userData.birthYear,
      'role': userData.role, 
      'faceId': userData.faceId, 
      'isHaveYellowCard': userData.isHaveYellowCard,
    });
  }

  Future<UserData> getUserData() async {
    UserData result = await kmitlFitnessCollection.document(uid).get().then((documentSnapshot){
      Map document = documentSnapshot.data;
      return UserData(
        uid:uid,
        firstName:document['firstName'],
        lastName:document['lastName'],
        email:document['email'],
        point: document['point'],
        membershipExpireDate:document['membershipExpireDate'],
        birthYear:document['birthYear'],
        role:document['role'],
        faceId:document['faceId'],
        isHaveYellowCard:document['isHaveYellowCard'],
      );
    });
    return result;
  }
   Future<void> updateMembership(String membershipExpireDate) async {
    return await kmitlFitnessCollection.document(uid).setData({
      'membershipExpireDate': membershipExpireDate,
    });
  }

}