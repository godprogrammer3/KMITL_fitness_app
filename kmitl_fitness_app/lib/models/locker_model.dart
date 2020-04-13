import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class LockerModel {
  final CollectionReference lockerCollection =
      Firestore.instance.collection('locker');
  final String uid;
  LockerModel({@required this.uid});

  Future<int> verifyPincode(String pincode,String lockerId) async {
    final snapshotPincode = await lockerCollection.document('pinCode').get();
    if (snapshotPincode.data['value'] == pincode) {
      await lockerCollection.document(lockerId).updateData({'user':this.uid});
      return 0;
    } else {
      return -1;
    }
  }

  Future<int> open() async {
    final snapshotQuerLocker = await lockerCollection
        .where('user', isEqualTo: this.uid)
        .getDocuments();
    if (snapshotQuerLocker.documents.length > 0) {
      final lockerId = snapshotQuerLocker.documents[0].documentID;
      await lockerCollection
          .document(lockerId)
          .updateData({'isLocked': false});
      return 0;
    } else {
      return -1;
    }
  }

  Future<int> lock() async {
   final snapshotQuerLocker = await lockerCollection
        .where('user', isEqualTo: this.uid)
        .getDocuments();
    if (snapshotQuerLocker.documents.length > 0) {
      final lockerId = snapshotQuerLocker.documents[0].documentID;
      await lockerCollection
          .document(lockerId)
          .updateData({'isLocked': true});
      return 0;
    } else {
      return -1;
    }
  }

  Future<int> returnLocker() async {
    final snapshotQuerLocker = await lockerCollection
        .where('user', isEqualTo: this.uid)
        .getDocuments();
    if (snapshotQuerLocker.documents.length > 0) {
      await lockerCollection
          .document(snapshotQuerLocker.documents[0].documentID)
          .updateData({'isLocked': true, 'user': ''});
      return 0;
    } else {
      return -1;
    }
  }

  List<Locker> _lockerFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Locker(
        id: doc.documentID,
        isLocked: doc.data['isLocked'],
        user: doc.data['user'],
      );
    }).toList();
  }

  Stream<List<Locker>> get lockers {
    return lockerCollection.snapshots().map(_lockerFromSnapshot);
  }
}
