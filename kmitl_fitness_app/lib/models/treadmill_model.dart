import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TreadMillModel{
  final String uid;
  final CollectionReference treadmillStatusCollection = Firestore.instance.collection('treadmill_status');
  TreadMillModel({
    @required this.uid
  });

  Future<void> enQueue() async {

  }
  Future<void> cancel() async {

  }

}