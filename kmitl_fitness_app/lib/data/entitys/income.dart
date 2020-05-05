import 'package:flutter/foundation.dart';

class Income{
  final String id;
  final DateTime time;
  final String user;
  final double value;
  final String packageId;

  Income({
    @required this.id, 
    @required this.time, 
    @required this.user, 
    @required this.value, 
    @required this.packageId});
}