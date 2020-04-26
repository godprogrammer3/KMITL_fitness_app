import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class PackageModel {
  final CollectionReference packageCollection =
      Firestore.instance.collection('package');
  final String uid;
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('package');
  PackageModel({@required this.uid});

  Future<int> create(Map<String, dynamic> data) async {
    data['owner'] = this.uid;
    final document = await packageCollection.add(data);
    await document.updateData({
      'createdTime': FieldValue.serverTimestamp(),
      'updatedTime': FieldValue.serverTimestamp(),
    });
    return 0;
  }

  Future<int> update(String id, Map<String, dynamic> updateData) async {
    updateData['updatedTime'] = FieldValue.serverTimestamp();
    await packageCollection.document(id).updateData(updateData);
    return 0;
  }

  List<Package> _packageFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Package(
        id: doc.documentID,
        title: doc.data['title'],
        detail: doc.data['detail'],
        price: doc.data['price'].toDouble(),
        pricePerDay: doc.data['pricePerDay'].toDouble(),
        createdTime: DateTime.fromMillisecondsSinceEpoch(
            (doc.data['createdTime'].seconds * 1000 +
                    doc.data['createdTime'].nanoseconds / 1000000)
                .round()),
        updatedTime: DateTime.fromMillisecondsSinceEpoch(
            (doc.data['updatedTime'].seconds * 1000 +
                    doc.data['updatedTime'].nanoseconds / 1000000)
                .round()),
        owner: doc.data['owner'],
        period: doc.data['period'],
        totalDay: doc.data['totalDay'],
      );
    }).toList();
  }

  Stream<List<Package>> get packages {
    return packageCollection.snapshots().map(_packageFromSnapshot);
  }

}
