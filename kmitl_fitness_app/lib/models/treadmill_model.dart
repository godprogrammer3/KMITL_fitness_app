import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';

class TreadmillModel{
  final String uid;
  final CollectionReference treadmillStatusCollection = Firestore.instance.collection('treadmill_status');
  final CollectionReference treadmillQueueCollection = Firestore.instance.collection('treadmill_queue');
  TreadmillModel({
    @required this.uid
  });
  Future<int> enQueue() async {
    final snapshots = await treadmillQueueCollection.getDocuments();
    if(snapshots.documents.length == 0){
      print('process to play');
      return 0;
    }else{
       final databaseModel = DatabaseModel(uid:this.uid);
       final userData = await databaseModel.getUserData();
       await treadmillQueueCollection.document(this.uid).setData({
         'firstName':userData.firstName
       });
       return 0;
    }
  }
  Future<void> skip() async {
    print('skip');
  }
  Future<void> cancel() async {
    print('cancel');
  }
  Future<void> done() async {
    print('done');
  }
  List<TreadmillStatus> _treadmillStatusFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return TreadmillStatus(
        status: doc.data['status']??'none',
        user: doc.data['user'] ?? '',
      );
    }).toList();
  }
  Stream<List<TreadmillStatus>> get status {
    return treadmillStatusCollection.snapshots()
      .map(_treadmillStatusFromSnapshot);
  }
  List<TreadmillQueue> _treadmillQueueFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return TreadmillQueue(
        firstName: doc.data['user'] ?? '',
      );
    }).toList();
  }
  Stream<List<TreadmillQueue>> get queues {
    return treadmillQueueCollection.snapshots()
      .map(_treadmillQueueFromSnapshot);
  }
}