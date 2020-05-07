import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:uuid/uuid.dart';
class PostModel {
  final String uid;
  final CollectionReference postCollection =
      Firestore.instance.collection('post');
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('post');
  PostModel({@required this.uid});
  var uuid = Uuid();
  Future<int> creatPost(Map<String, dynamic> postData, File imageFile) async {
    try {
      postData['owner'] = this.uid;
      final document = await postCollection.add(postData);
      postData['imageId'] = uuid.v4();
      await document.updateData({
        'createdTime': FieldValue.serverTimestamp(),
        'updatedTime': FieldValue.serverTimestamp(),
        'imageId': postData['imageId'],
      });
      StorageUploadTask uploadTask =
          storageReference.child(postData['imageId']).putFile(imageFile);
      await uploadTask.onComplete;
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> updatePost(
      String postId, Map<String, dynamic> updateData, File imageFile) async {
    try {
      updateData['updatedTime'] = FieldValue.serverTimestamp();
      if (imageFile != null) {
        updateData['imageId'] = uuid.v4();
        StorageUploadTask uploadTask =
            storageReference.child( updateData['imageId']).putFile(imageFile);
        await uploadTask.onComplete;
      }
      await postCollection.document(postId).updateData(updateData);
      return 0;
    } catch (error) {
      return -1;
    }
  }

  Future<int> deletePost(String postId) async {
    await postCollection.document(postId).delete();
    //await storageReference.child(postId).delete();
    return 0;
  }

  List<Post> _postFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(
        id: doc.documentID,
        title: doc.data['title'],
        imageUrl: doc.data['imageId'],
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
      );
    }).toList();
  }

  Stream<List<Post>> get posts {
    return postCollection.snapshots().map(_postFromSnapshot);
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
