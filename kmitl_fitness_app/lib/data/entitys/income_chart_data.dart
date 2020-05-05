import 'package:flutter/foundation.dart';

class IncomeChartData implements Comparable {
  final DateTime date;
  final double value;

  IncomeChartData({
    @required this.date, 
    @required this.value
  });
  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }
}