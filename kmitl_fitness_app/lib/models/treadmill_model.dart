import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';

class TreadmillModel {
  final String uid;
  final CollectionReference treadmillStatusCollection =
      Firestore.instance.collection('treadmill_status');
  final CollectionReference treadmillQueueCollection =
      Firestore.instance.collection('treadmill_queue');
  TreadmillModel({@required this.uid});
  Future<int> enQueue() async {
    try {
      final snapshots = await treadmillQueueCollection.getDocuments();
      if (snapshots.documents.length == 0) {
        final treadmillStatusSnapshot =
            await treadmillStatusCollection.getDocuments();
        for (var i = 0; i < treadmillStatusSnapshot.documents.length; i++) {
          if (treadmillStatusSnapshot.documents[i]['user'] == this.uid) {
            return -1;
          }
          if (treadmillStatusSnapshot.documents[i]['user'] == '') {
            await treadmillStatusCollection
                .document(i.toString())
                .updateData({'user': this.uid});
            return 0;
          }
        }
        final userModel = UserModel(uid: this.uid);
        final userData = await userModel.getUserData();
        await treadmillQueueCollection.document(this.uid).setData({
          'queueNumber': 0,
          'firstName': userData.firstName,
        });
        return 0;
      } else {
        final snapshotCheck =
            await treadmillQueueCollection.document(this.uid).get();
        if (snapshotCheck.exists) {
          return -1;
        }
        final userModel = UserModel(uid: this.uid);
        final userData = await userModel.getUserData();
        final query = treadmillQueueCollection
            .orderBy('queueNumber', descending: true)
            .limit(1);
        final snapshots = await query.getDocuments();
        await treadmillQueueCollection.document(this.uid).setData({
          'queueNumber': snapshots.documents[0]['queueNumber'] + 1,
          'firstName': userData.firstName,
        });
        return 0;
      }
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<int> skip() async {
    final snapshotMe = await treadmillQueueCollection.document(this.uid).get();
    if (!snapshotMe.exists) {
      return -1;
    }
    final queryMax = treadmillQueueCollection
        .orderBy('queueNumber', descending: true)
        .limit(1);
    final snapshotMax = await queryMax.getDocuments();
    if (snapshotMax.documents[0]['queueNumber'] == snapshotMe['queueNumber']) {
      return -2;
    }
    final queryNext = treadmillQueueCollection
        .where('queueNumber', isGreaterThan: snapshotMe['queueNumber'])
        .orderBy('queueNumber')
        .limit(1);
    final snapshotNext = await queryNext.getDocuments();
    await treadmillQueueCollection
        .document(snapshotMe.documentID)
        .updateData({'queueNumber': snapshotNext.documents[0]['queueNumber']});
    await treadmillQueueCollection
        .document(snapshotNext.documents[0].documentID)
        .updateData({'queueNumber': snapshotMe['queueNumber']});
    final snapshotQueueMeStatus = await treadmillStatusCollection
        .where('user', isEqualTo: this.uid)
        .getDocuments();
    await treadmillStatusCollection
        .document(snapshotQueueMeStatus.documents[0].documentID)
        .updateData({'isAvailable': true, 'user': '', 'startTime': -1});
    return 0;
  }

  Future<int> cancel() async {
    try {
      final snapshotMe =
          await treadmillQueueCollection.document(this.uid).get();
      if (!snapshotMe.exists) {
        return -1;
      }
      await treadmillQueueCollection.document(this.uid).delete();
      return 0;
    } catch (error) {
      return -2;
    }
  }

  Future<int> done() async {
    final snapshotMe = await treadmillStatusCollection
        .where('user', isEqualTo: this.uid)
        .getDocuments();
    if (snapshotMe.documents.length != 0) {
      await treadmillStatusCollection
          .document(snapshotMe.documents[0].documentID)
          .updateData({'isAvailable': true, 'user': '', 'startTime': -1});
      return 0;
    } else {
      return -1;
    }
  }

  List<TreadmillStatus> _treadmillStatusFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return TreadmillStatus(
        id: doc.documentID,
        isAvailable: doc.data['isAvailable'] ?? false,
        user: doc.data['user'] ?? '',
        startTime: doc.data['startTime'] == -1
            ? null
            : DateTime != null
                ? DateTime.fromMillisecondsSinceEpoch(doc.data['startTime'])
                : null,
      );
    }).toList();
  }

  Stream<List<TreadmillStatus>> get status {
    return treadmillStatusCollection
        .snapshots()
        .map(_treadmillStatusFromSnapshot);
  }

  List<TreadmillQueue> _treadmillQueueFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return TreadmillQueue(
        user: doc.documentID,
        queueNumber: doc.data['queueNumber'] ?? -1,
        firstName: doc.data['firstName'] ?? '',
      );
    }).toList();
  }

  Stream<List<TreadmillQueue>> get queues {
    return treadmillQueueCollection
        .snapshots()
        .map(_treadmillQueueFromSnapshot);
  }

  Future<int> checkValidNotifications() async {
    final snapshot = await treadmillStatusCollection
        .where('user', isEqualTo: this.uid)
        .getDocuments();
    if (snapshot.documents.length != 0) {
      if (snapshot.documents[0]['isAvailable'] == true) {
        return 0;
      } else {
        return 1;
      }
    } else {
      return -1;
    }
  }

  Future<int> checkUserStatus() async {
    final snapshotQueryStatus = await treadmillStatusCollection
        .where('user', isEqualTo: this.uid)
        .where('isAvailable', isEqualTo: false)
        .getDocuments();
    if (snapshotQueryStatus.documents.length != 0) {
      return 0;
    }
    final snapshotQueryQueue =
        await treadmillQueueCollection.document(this.uid).get();
    if (snapshotQueryQueue.exists) {
      return 1;
    }
    return 2;
  }
}
