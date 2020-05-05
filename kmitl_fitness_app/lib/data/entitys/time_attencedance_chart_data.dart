import 'package:flutter/foundation.dart';

class TimeAttendanceChartData implements Comparable {
  final DateTime date;
  final int totalPerson;

  TimeAttendanceChartData({
    @required this.date, 
    @required this.totalPerson
  });

  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }
}