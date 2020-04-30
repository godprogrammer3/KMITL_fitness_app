import 'package:flutter/foundation.dart';

class Notification implements Comparable{
  final String id;
  final String title;
  final String detail;
  final String type;
  final List<String> users;
  final DateTime createdTime;
  Notification({
    @required this.id, 
    @required this.title, 
    @required this.detail, 
    @required this.type, 
    @required this.users,
    @required this.createdTime, 
  });
  @override
  int compareTo(other) {
    return createdTime.compareTo(other.createdTime);
  }
}