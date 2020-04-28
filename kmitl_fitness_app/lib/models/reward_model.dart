import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';

class RewardModel {
  final CollectionReference rewardCollection =
      Firestore.instance.collection('reward');
  final String uid;
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('reward');
  RewardModel({@required this.uid});

  Future<int> create(Map<String, dynamic> rewardData, File imageFile) async {
    try {
      rewardData['owner'] = this.uid;
      final document = await rewardCollection.add(rewardData);
      await document.updateData({
        'createdTime': FieldValue.serverTimestamp(),
        'updatedTime': FieldValue.serverTimestamp(),
      });
      StorageUploadTask uploadTask =
          storageReference.child(document.documentID).putFile(imageFile);
      await uploadTask.onComplete;
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> update(
      String rewardId, Map<String, dynamic> updateData, File imageFile) async {
    try {
      updateData['updatedTime'] = FieldValue.serverTimestamp();
      if (imageFile != null) {
        StorageUploadTask uploadTask =
            storageReference.child(rewardId).putFile(imageFile);
        await uploadTask.onComplete;
      }
      await rewardCollection.document(rewardId).updateData(updateData);
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> delete(String id) async {
    try{
      await rewardCollection.document(id).delete();
      return 0;
    }catch (error) {
      return -1;
    }
  }

  Future<int> redeem(String rewardId) async {
    final snapshotReward = await rewardCollection.document(rewardId).get();
    final userModel = UserModel(uid: this.uid);
    final userData = await userModel.getUserData();
    var persons;
    if( snapshotReward['person'] != null){
      persons = List<String>.from(snapshotReward['person']);
    }
    if (snapshotReward['point'] > userData.point) {
      return -1;
    } else if (snapshotReward['quantity'] <= 0) {
      return -2;
    }else if (snapshotReward['person'] != null && persons.contains(this.uid)) {
      return -3;
    } 
    await rewardCollection.document(rewardId).updateData({
      'quantity': FieldValue.increment(-1),
      'person': FieldValue.arrayUnion([this.uid])
    });
    await userModel.updateUserData({'point':userData.point-snapshotReward['point']});
    return 0;
  }

  List<Reward> _rewardFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Reward(
        id: doc.documentID,
        title: doc.data['title'],
        detail: doc.data['detail'],
        point: doc.data['point'],
        quantity: doc.data['quantity'],
        createdTime: DateTime.fromMillisecondsSinceEpoch(
            (doc.data['createdTime'].seconds * 1000 +
                    doc.data['createdTime'].nanoseconds / 1000000)
                .round()),
        updatedTime: DateTime.fromMillisecondsSinceEpoch(
            (doc.data['updatedTime'].seconds * 1000 +
                    doc.data['updatedTime'].nanoseconds / 1000000)
                .round()),
        owner: doc.data['owner'],
        person: doc.data['person']!=null?List<String>.from(doc.data['person']):null,
      );
    }).toList();
  }

  Stream<List<Reward>> get rewards {
    return rewardCollection.snapshots().map(_rewardFromSnapshot);
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
