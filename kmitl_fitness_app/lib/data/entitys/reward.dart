import 'package:flutter/foundation.dart';
class Reward{
  final String id;
  final String title; 
  final String detail;
  final int point;
  final int quantity;
  final DateTime createdTime;
  final DateTime updatedTime;
  final String owner;
  final List<String> person;
  Reward( {
    @required this.id, 
    @required this.title, 
    @required this.detail,
    @required this.point, 
    @required this.quantity, 
    @required this.createdTime,  
    @required this.updatedTime, 
    @required this.owner, 
    @required this.person,
  });

}