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
    classData['totalPerson'] = 0;
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
    updateData['updatedTime'] = FieldValue.serverTimestamp();  
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
      return -2;
    }else if (DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch((snapshotClass['beginDateTime'].seconds*1000+snapshotClass['beginDateTime'].nanoseconds/1000000).round()))
            .inHours >=
        0) {
      return -3;
    }else if( DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch((snapshotClass['beginDateTime'].seconds*1000+snapshotClass['beginDateTime'].nanoseconds/1000000).round()))
            .inHours > -2 ){
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
          .setData({'reserve': true});
      return 0;

    }else{
      await updateClass(
          classId, {'totalPerson': FieldValue.increment(1)}, null);
      await classCollection
          .document(classId)
          .collection('person')
          .document(this.uid)
          .setData({'reserve': true});
      return 0;
    } 
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
      return -2;
    }else if( DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch((snapshotClass['beginDateTime'].seconds*1000+snapshotClass['beginDateTime'].nanoseconds/1000000).round()))
            .inHours > -2){
      return -3;
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
        createdTime: DateTime.fromMillisecondsSinceEpoch((doc.data['createdTime'].seconds*1000+doc.data['createdTime'].nanoseconds/1000000).round()),
        updatedTime: DateTime.fromMillisecondsSinceEpoch((doc.data['updatedTime'].seconds*1000+doc.data['updatedTime'].nanoseconds/1000000).round()),
        beginDateTime: DateTime.fromMillisecondsSinceEpoch((doc.data['beginDateTime'].seconds*1000+doc.data['beginDateTime'].nanoseconds/1000000).round()),
        endDateTime: DateTime.fromMillisecondsSinceEpoch((doc.data['endDateTime'].seconds*1000+doc.data['endDateTime'].nanoseconds/1000000).round()),
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
