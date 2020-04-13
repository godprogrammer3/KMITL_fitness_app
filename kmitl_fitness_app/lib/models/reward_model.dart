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

  Future<void> create(Map<String, dynamic> rewardData, File imageFile) async {
    rewardData['owner'] = this.uid;
    final document = await rewardCollection.add(rewardData);
    await document.updateData({
      'createdTime': FieldValue.serverTimestamp(),
      'updatedTime': FieldValue.serverTimestamp(),
      'imageId': document.documentID,
    });
    StorageUploadTask uploadTask =
        storageReference.child(document.documentID).putFile(imageFile);
    return await uploadTask.onComplete;
  }

 Future<void> update(
      String rewardId, Map<String, dynamic> updateData, File imageFile) async {
    updateData['updatedTime'] = FieldValue.serverTimestamp();  
    if (imageFile != null) {
      StorageUploadTask uploadTask =
          storageReference.child(rewardId).putFile(imageFile);
      await uploadTask.onComplete;
    }
    return await rewardCollection.document(rewardId).updateData(updateData);
  }

  Future<int> redeem(String rewardId) async {
    final snapshotReward = await rewardCollection.document(rewardId).get();
    final userModel = UserModel(uid: this.uid);
    final userData = await userModel.getUserData();
    if( snapshotReward['point'] > userData.point){
      return -1;
    }else if( snapshotReward['persons'].contains(this.uid)){
      return -2;
    }else if( snapshotReward['quantity'] <= 0){
      return -3;
    }
    await rewardCollection.document(rewardId).updateData({
      'quantity': FieldValue.increment(-1),
      'person':  FieldValue.arrayUnion([this.uid])
    });
    return 0;
  }

  List<Reward> _rewardFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Reward(
        id: doc.documentID,
        imageId: doc.data['imageId'],
        title: doc.data['title'],
        point: doc.data['point'],
        quantity: doc.data['quantity'],
        beginDateTime: DateTime.fromMillisecondsSinceEpoch((doc.data['beginDateTime'].seconds*1000+doc.data['beginDateTime'].nanoseconds/1000000).round()),
        endDateTime: DateTime.fromMillisecondsSinceEpoch((doc.data['endDateTime'].seconds*1000+doc.data['endDateTime'].nanoseconds/1000000).round()),
        createdTime: DateTime.fromMillisecondsSinceEpoch((doc.data['createdTime'].seconds*1000+doc.data['createdTime'].nanoseconds/1000000).round()),
        updatedTime:  DateTime.fromMillisecondsSinceEpoch((doc.data['updatedTime'].seconds*1000+doc.data['updatedTime'].nanoseconds/1000000).round()),
        owner: doc.data['owner'],
        person: doc.data['person'],
      );
    }).toList();
  }

  Stream<List<Reward>> get rewards {
    return rewardCollection.snapshots().map(_rewardFromSnapshot);
  }
  Future<Image> getImageFromImageId(String imageId) async {
    final imageUrl = await storageReference.child(imageId).getDownloadURL();
    return Image.network(imageUrl);
  }
}
