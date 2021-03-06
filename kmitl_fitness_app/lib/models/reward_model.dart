import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:uuid/uuid.dart';
class RewardModel {
  final CollectionReference rewardCollection =
      Firestore.instance.collection('reward');
  final String uid;
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('reward');
  RewardModel({@required this.uid});
  var uuid = Uuid();
  Future<int> create(Map<String, dynamic> rewardData, File imageFile) async {
    try {
      rewardData['owner'] = this.uid;
      final document = await rewardCollection.add(rewardData);
      rewardData['imageId'] = uuid.v4();
      await document.updateData({
        'createdTime': FieldValue.serverTimestamp(),
        'updatedTime': FieldValue.serverTimestamp(),
        'imageId': rewardData['imageId'],
      });
      StorageUploadTask uploadTask =
          storageReference.child(rewardData['imageId']).putFile(imageFile);
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
        updateData['imageId'] = uuid.v4();
        StorageUploadTask uploadTask =
            storageReference.child(updateData['imageId']).putFile(imageFile);
        await uploadTask.onComplete;
      }
      await rewardCollection.document(rewardId).updateData(updateData);
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> delete(String id) async {
    try {
      await rewardCollection.document(id).delete();
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> redeem(String rewardId) async {
    try {
      final snapshotReward = await rewardCollection.document(rewardId).get();
      final userModel = UserModel(uid: this.uid);
      final userData = await userModel.getUserData();
      if (snapshotReward['type'] == 'goods') {
        var persons;
        if (snapshotReward['person'] != null) {
          persons = List<String>.from(snapshotReward['person']);
        }
        if (snapshotReward['point'] > userData.point) {
          return -1;
        } else if (snapshotReward['quantity'] <= 0) {
          return -2;
        } else if (snapshotReward['person'] != null &&
            persons.contains(this.uid)) {
          return -3;
        }
        await rewardCollection.document(rewardId).updateData({
          'quantity': FieldValue.increment(-1),
          'person': FieldValue.arrayUnion([this.uid])
        });
        await userModel.updateUserData(
            {'point': userData.point - snapshotReward['point']}, null);
        return 0;
      } else {
        if (userData.discount >= 0) {
          return -5;
        } else if (snapshotReward['point'] > userData.point) {
          return -1;
        }
        final result = await userModel.updateUserData({
          'discount': snapshotReward['percent'],
          'point': userData.point - snapshotReward['point']
        }, null);
        if (result == 0) {
          return 0;
        } else {
          return -4;
        }
      }
    } catch (error) {
      return -4;
    }
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
        person: doc.data['person'] != null
            ? List<String>.from(doc.data['person'])
            : null,
        type: doc.data['type'],
        percent: doc.data['percent'],
        imageId: (doc.data['imageId'] != null)?doc.data['imageId']:doc.documentID,
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

  Future<List<Map<String, dynamic>>> getPersons(String id) async {
    try {
      List<Map<String, dynamic>> result = List<Map<String, dynamic>>();
      final snapshotReward = await rewardCollection.document(id).get();
      if (snapshotReward['person'] != null) {
        for (var i in snapshotReward['person']) {
            final UserData userData =
          await UserModel(uid: i).getUserData();
          if (snapshotReward['checkedPerson'] != null) {
            if (snapshotReward['checkedPerson'].contains(i)) {
              result.add({'uid': i, 'isChecked': true,'firstName':userData.firstName});
            } else {
              result.add({'uid': i, 'isChecked': false,'firstName':userData.firstName});
            }
          } else {
            result.add({'uid': i, 'isChecked': false,'firstName':userData.firstName});
          }
        }
      }
      return result;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<int> checkPersons(
      String id, List<Map<String, dynamic>> persons) async {
    try {
      for (var i in persons) {
        if (i['isChecked']) {
          await rewardCollection.document(id).updateData({
            'checkedPerson': FieldValue.arrayUnion([i['uid']]),
          });
        }
      }
      return 0;
    } catch (error) {
      print(error);
      return -1;
    }
  }
}
