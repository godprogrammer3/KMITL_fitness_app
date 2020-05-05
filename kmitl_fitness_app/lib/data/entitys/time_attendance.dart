import 'package:flutter/foundation.dart';

class TimeAttendance{
  final String id;
  final String type;
  final String user;
  final DateTime time;

  TimeAttendance({
    @required this.id, 
    @required this.type, 
    @required this.user, 
    @required this.time});
}