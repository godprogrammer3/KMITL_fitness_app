import 'package:flutter/foundation.dart';
class Reward{
  final String id;
  final String imageId;
  final String title; 
  final int point;
  final int quantity;
  final DateTime beginDateTime;
  final DateTime endDateTime;
  final DateTime createdTime;
  final DateTime updatedTime;
  final String owner;
  final List<String> person;
  Reward({
    @required this.id, 
    @required this.imageId, 
    @required this.title, 
    @required this.point, 
    @required this.quantity, 
    @required this.beginDateTime,  
    @required this.endDateTime,  
    @required this.createdTime,  
    @required this.updatedTime, 
    @required this.owner, 
    @required this.person,
  });

}