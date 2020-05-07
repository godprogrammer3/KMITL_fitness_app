import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:uuid/uuid.dart';

class UserModel {
  final String uid;
  UserModel({@required this.uid});
  var uuid = Uuid();
  final CollectionReference userDataCollection =
      Firestore.instance.collection('userdata');
  final StorageReference storageReference =
      FirebaseStorage.instance.ref().child('userdata');
  Future<void> setUserData(Map<String, dynamic> updateData) async {
    return await userDataCollection.document(uid).setData(updateData);
  }

  Future<int> updateUserData(
      Map<String, dynamic> updateData, File imageFile) async {
    try {
      if (imageFile != null) {
        updateData['imageId'] = uuid.v4();
        StorageUploadTask uploadTask =
            storageReference.child(updateData['imageId']).putFile(imageFile);
        await uploadTask.onComplete;
      }
      await userDataCollection.document(uid).updateData(updateData);
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> updateFaceId(File imageFile) async {
    try {
      if (imageFile != null) {
        StorageUploadTask uploadTask =
            storageReference.child(this.uid + '.faceid').putFile(imageFile);
        await uploadTask.onComplete;
        Map<String, dynamic> data = {
          'faceId': this.uid + '.faceid',
        };
        return await updateUserData(data, null);
      }
      return -1;
    } catch (error) {
      return -1;
    }
  }

  Future<UserData> getUserData() async {
    try {
      final snapshot = await userDataCollection.document(uid).get();
      if (snapshot == null) {
        return null;
      }
      return UserData(
        uid: uid,
        firstName: snapshot['firstName'],
        lastName: snapshot['lastName'],
        email: snapshot['email'],
        point: snapshot['point'],
        membershipExpireDate: DateTime.fromMillisecondsSinceEpoch(
                (snapshot['membershipExpireDate'].seconds * 1000 +
                        snapshot['membershipExpireDate'].nanoseconds / 1000000)
                    .round()) ??
            null,
        birthDate: snapshot['birthDate'],
        role: snapshot['role'],
        faceId: snapshot['faceId'],
        isHaveYellowCard: snapshot['isHaveYellowCard'],
        imageId: snapshot['imageId'],
        phoneNumber: snapshot['phoneNumber'],
        type: snapshot['type'],
       
        discount: snapshot['discount']+.0,
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<String> getUrlFromImageId(String imageId) async {
    try {
      final url = await storageReference.child(imageId).getDownloadURL();
      return url;
    } catch (error) {
      return null;
    }
  }
}
