import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class NotificationModel{
  final String uid;
  final CollectionReference notificationCollection =
      Firestore.instance.collection('notification');
  NotificationModel({
    @required this.uid
  });

   List<Notification> _notificationFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Notification(
        id: doc.documentID,
        title: doc.data['title'],
        detail: doc.data['detail'],
        type: doc.data['type'],
        users: doc.data['users']!=null?List<String>.from(doc.data['users']):null,
        createdTime: DateTime.fromMillisecondsSinceEpoch((doc.data['createdTime'].seconds*1000+doc.data['createdTime'].nanoseconds/1000000).round()),
      );
    }).toList();
  }

  Stream<List<Notification>> get notifications {
    return notificationCollection.snapshots().map(_notificationFromSnapshot);
  }

}