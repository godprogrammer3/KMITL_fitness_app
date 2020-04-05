import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class PostModel {
  final String uid;
  final CollectionReference postCollection =
      Firestore.instance.collection('post');
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('post');
  PostModel({@required this.uid});

  Future<void> creatPost(Map<String, dynamic> postData, File imageFile) async {
    postData['owner'] = this.uid;
    final document = await postCollection.add(postData);
    await document.updateData({
      'createdTime': FieldValue.serverTimestamp(),
      'updatedTime': FieldValue.serverTimestamp(),
      'imageId':document.documentID
    });
    StorageUploadTask uploadTask =
        storageReference.child(document.documentID).putFile(imageFile);
    return await uploadTask.onComplete;
  }

  Future<void> updatePost(
      String postId, Map<String, dynamic> updateData, File imageFile) async {
    updateData['updatedTime'] = FieldValue.serverTimestamp();  
    if (imageFile != null) {
      StorageUploadTask uploadTask =
          storageReference.child(postId).putFile(imageFile);
      await uploadTask.onComplete;
    }
    return await postCollection.document(postId).updateData(updateData);
  }

  List<Post> _postFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(
        id: doc.documentID,
        title: doc.data['title'],
        imageId: doc.data['imageId'],
        detail: doc.data['detail'],
        owner: doc.data['owner'],
        createdTime:DateTime.fromMillisecondsSinceEpoch((doc.data['createdTime'].seconds*1000+doc.data['createdTime'].nanoseconds/1000000).round()),
        updatedTime:  DateTime.fromMillisecondsSinceEpoch((doc.data['updatedTime'].seconds*1000+doc.data['updatedTime'].nanoseconds/1000000).round()),
      );
    }).toList();
  }

  Stream<List<Post>> get posts {
    return postCollection.snapshots().map(_postFromSnapshot);
  }

  Future<Image> getImageFromImageId(String imageId) async {
    final imageUrl = await storageReference.child(imageId).getDownloadURL();
    return Image.network(imageUrl);
  }
}
