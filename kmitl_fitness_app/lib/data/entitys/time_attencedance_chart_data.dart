import 'package:flutter/foundation.dart';

class TimeAttendanceChartData{
  final DateTime date;
  final int totalPerson;

  TimeAttendanceChartData({
    @required this.date, 
    @required this.totalPerson
  });
}