import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class UserModel {

  final String uid;
  UserModel({ 
    @required this.uid 
  });

  final CollectionReference userDataCollection = Firestore.instance.collection('userdata');
  final StorageReference storageReference =
      FirebaseStorage.instance.ref().child('userdata');
  Future<void> setUserData(Map<String, dynamic> updateData) async {
    return await userDataCollection.document(uid).setData(updateData);
  }
  Future<int> updateUserData(Map<String, dynamic> updateData,File imageFile) async {
    try{
      if (imageFile != null) {
      StorageUploadTask uploadTask =
          storageReference.child(this.uid).putFile(imageFile);
      await uploadTask.onComplete;
      updateData['imageId'] = this.uid;
    }
      await userDataCollection.document(uid).updateData(updateData);
      return 0;
    }catch(error){
      return -1;
    }
    
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
        birthDate:snapshot['birthDate'],
        role:snapshot['role'],
        faceId:snapshot['faceId'],
        isHaveYellowCard:snapshot['isHaveYellowCard'], 
        imageId: snapshot['imageId'],
        phoneNumber: snapshot['phoneNumber']
      );
  }
   Future<String> getUrlFromImageId(String imageId) async {
    try{
      final url = await storageReference.child(imageId).getDownloadURL();
      return url;
    }catch (error) {
      return null;
    }
    
  }

}