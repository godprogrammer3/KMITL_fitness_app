import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';

class ClassModel {
  final String uid;
  final CollectionReference classCollection =
      Firestore.instance.collection('class');
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('class');
  ClassModel({@required this.uid});

  Future<int> creatClass(Map<String, dynamic> classData, File imageFile) async {
    try {
      classData['owner'] = this.uid;
      classData['totalPerson'] = 0;
      final userData = await UserModel(uid: this.uid).getUserData();
      classData['ownerFirstname'] = userData.firstName;
      final document = await classCollection.add(classData);
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

  Future<int> updateClass(
      String classId, Map<String, dynamic> updateData, File imageFile) async {
    try {
      updateData['updatedTime'] = FieldValue.serverTimestamp();
      if (imageFile != null) {
        StorageUploadTask uploadTask =
            storageReference.child(classId).putFile(imageFile);
        await uploadTask.onComplete;
      }
      await classCollection.document(classId).updateData(updateData);
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> deleteClass(String classId) async {
    try {
      final snapshotQuery = await classCollection.document(classId).collection('person').getDocuments();
      for(var i in snapshotQuery.documents){
        await classCollection.document(classId).collection('person').document(i.documentID).delete();
      }
      await classCollection.document(classId).delete();
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getPersons(String id) async {
    final snapshotPerson =
        await classCollection.document(id).collection('person').getDocuments();
    List<Map<String, dynamic>> persons = List<Map<String, dynamic>>();
    for (var i in snapshotPerson.documents) {
      final UserData userData =
          await UserModel(uid: i.documentID).getUserData();
      persons.add({
        'uid': i.documentID,
        'firstName': userData.firstName,
        'isChecked': i['isChecked']
      });
    }
    return persons;
  }

  Future<int> checkPersons(
      String id, List<Map<String, dynamic>> persons) async {
    try {
      for (var i in persons) {
        if( i['isChecked'] == true){
           await classCollection
            .document(id)
            .collection('person')
            .document(i['uid'])
            .updateData({'isChecked': i['isChecked']});
        }else{
          await UserModel(uid:i['uid']).updateUserData({'isHaveYellowCard':true}, null);
        }
       
      }
      await classCollection.document(id).updateData({'isChecked':true});
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> reserveClass(String classId) async {
    final snapshotClass = await classCollection.document(classId).get();
    final snapshotPerson = await classCollection
        .document(classId)
        .collection('person')
        .getDocuments();
    if (!snapshotClass.exists) {
      return -1;
    } else if (snapshotClass['totalPerson'] >= snapshotClass['limitPerson']) {
      return -2;
    } else if (DateTime.now()
            .isAfter(DateTime.fromMillisecondsSinceEpoch(
                (snapshotClass['beginDateTime'].seconds * 1000 +
                        snapshotClass['beginDateTime'].nanoseconds / 1000000)
                    .round()))
             ) {
      return -3;
    } else if (DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch(
                (snapshotClass['beginDateTime'].seconds * 1000 +
                        snapshotClass['beginDateTime'].nanoseconds / 1000000)
                    .round()))
            .inMinutes >
        -30) {
      return -4;
    } else if (snapshotPerson.documents.length > 0) {
      for (var i in snapshotPerson.documents) {
        if (i.documentID == this.uid) {
          return -5;
        }
      }
      await updateClass(
          classId, {'totalPerson': FieldValue.increment(1)}, null);
      await classCollection
          .document(classId)
          .collection('person')
          .document(this.uid)
          .setData({'isChecked': false});
      return 0;
    } else {
      await updateClass(
          classId, {'totalPerson': FieldValue.increment(1)}, null);
      await classCollection
          .document(classId)
          .collection('person')
          .document(this.uid)
          .setData({'isChecked': false});
      return 0;
    }
  }

  Future<int> cancelClass(String classId) async {
    final snapshotClass = await classCollection.document(classId).get();
    final snapshotPerson = await classCollection
        .document(classId)
        .collection('person')
        .getDocuments();
    final snapshotThisPerson = await classCollection
        .document(classId)
        .collection('person')
        .document(this.uid)
        .get();
    if (snapshotPerson.documents.length == 0) {
      return -1;
    } else if (!snapshotThisPerson.exists) {
      return -2;
    } else if (DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch(
                (snapshotClass['beginDateTime'].seconds * 1000 +
                        snapshotClass['beginDateTime'].nanoseconds / 1000000)
                    .round()))
            .inMinutes >
        -30) {
      print(DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
          (snapshotClass['beginDateTime'].seconds * 1000 +
                  snapshotClass['beginDateTime'].nanoseconds / 1000000)
              .round())));
      return -3;
    } else {
      await updateClass(
          classId, {'totalPerson': FieldValue.increment(-1)}, null);
      await classCollection
          .document(classId)
          .collection('person')
          .document(this.uid)
          .delete();
      return 0;
    }
  }

  List<Class> _classFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Class(
        id: doc.documentID,
        title: doc.data['title'],
        imageId: doc.documentID,
        detail: doc.data['detail'],
        owner: doc.data['owner'],
        createdTime: DateTime.fromMillisecondsSinceEpoch(
            (doc.data['createdTime'].seconds * 1000 +
                    doc.data['createdTime'].nanoseconds / 1000000)
                .round()),
        updatedTime: DateTime.fromMillisecondsSinceEpoch(
            (doc.data['updatedTime'].seconds * 1000 +
                    doc.data['updatedTime'].nanoseconds / 1000000)
                .round()),
        beginDateTime: DateTime.fromMillisecondsSinceEpoch(
            (doc.data['beginDateTime'].seconds * 1000 +
                    doc.data['beginDateTime'].nanoseconds / 1000000)
                .round()),
        endDateTime: DateTime.fromMillisecondsSinceEpoch(
            (doc.data['endDateTime'].seconds * 1000 +
                    doc.data['endDateTime'].nanoseconds / 1000000)
                .round()),
        limitPerson: doc.data['limitPerson'],
        totalPerson: doc.data['totalPerson'],
        ownerFirstname: doc.data['ownerFirstname'],
        isChecked: doc.data['isChecked'],
      );
    }).toList();
  }

  Stream<List<Class>> get classes {
    return classCollection.snapshots().map(_classFromSnapshot);
  }

  Future<String> getUrlFromImageId(String imageId) async {
    try {
      final url = await storageReference.child(imageId).getDownloadURL();
      return url;
    } catch (error) {
      return null;
    }
  }

  Future<bool> isReserved(String classId) async {
    final snapshotThisPerson = await classCollection
        .document(classId)
        .collection('person')
        .document(this.uid)
        .get();
    return snapshotThisPerson.exists;
  }
}
