import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class ClassModel {
  final String uid;
  final CollectionReference classCollection =
      Firestore.instance.collection('class');
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('class');
  ClassModel({@required this.uid});

  Future<void> creatClass(
      Map<String, dynamic> classData, File imageFile) async {
    classData['owner'] = this.uid;
    final document = await classCollection.add(classData);
    await document.updateData({
      'createdTime': FieldValue.serverTimestamp(),
      'updatedTime': FieldValue.serverTimestamp(),
    });
    StorageUploadTask uploadTask =
        storageReference.child(document.documentID).putFile(imageFile);
    return await uploadTask.onComplete;
  }

  Future<void> updateClass(
      String classId, Map<String, dynamic> updateData, File imageFile) async {
    if (imageFile != null) {
      StorageUploadTask uploadTask =
          storageReference.child(classId).putFile(imageFile);
      await uploadTask.onComplete;
    }
    return await classCollection.document(classId).updateData(updateData);
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
      return -1;
    } else if (DateTime.now()
            .difference(snapshotClass['beginDateTime'])
            .inHours <
        1) {
      return -1;
    } else if (snapshotPerson.documents.length > 0) {
      for (var i in snapshotPerson.documents) {
        if (i.documentID == this.uid) {
          return -1;
        }
      }
    } else {
      await updateClass(
          classId, {'totalPerson': FieldValue.increment(1)}, null);
      await classCollection
          .document(classId)
          .collection('person')
          .document(this.uid)
          .setData({'reserve': true});
      return 0;
    }
    return -1;
  }

  Future<int> cancelClass(String classId) async {
    final snapshotClass = await classCollection.document(classId).get();
    final snapshotPerson = await classCollection
        .document(classId)
        .collection('person')
        .getDocuments();
    final snapshotThisPerson = await classCollection.document(classId).collection('person').document(this.uid).get();
    if(snapshotPerson.documents.length == 0){
      return -1;
    }else if( !snapshotThisPerson.exists){
      return -1;
    }else if( DateTime.now().difference(snapshotClass['beginDateTime']).inHours <= 2){
      return -1;
    }else{
      await updateClass(
          classId, {'totalPerson': FieldValue.increment(-1)}, null);
      await classCollection.document(classId).collection('person').document(this.uid).delete();
      return 0;
    }
  }

  List<Class> _classFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Class(
        id: doc.documentID,
        title: doc.data['title'],
        imageId: doc.data['imageId'],
        detail: doc.data['detail'],
        owner: doc.data['owner'],
        createdTime: doc.data['createdTime'],
        updatedTime: doc.data['updatedTime'],
        beginDateTime: doc.data['beginDateTime'],
        endDateTime: doc.data['endDateTime'],
        limitPerson: doc.data['limitPerson'],
        totalPerson: doc.data['totalPerson'],
      );
    }).toList();
  }

  Stream<List<Class>> get classes {
    return classCollection.snapshots().map(_classFromSnapshot);
  }

  Future<Image> getImageFromImageId(String imageId) async {
    final imageUrl = await storageReference.child(imageId).getDownloadURL();
    return Image.network(imageUrl);
  }
}
