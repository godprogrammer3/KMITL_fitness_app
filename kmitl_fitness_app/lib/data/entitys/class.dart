import 'package:flutter/foundation.dart';

class Class{
  final String id;
  final String title;
  final String detail;
  final String imageId;
  final String owner;  
  final DateTime beginDateTime;
  final DateTime endDateTime;
  final DateTime createdTime;
  final DateTime updatedTime;
  final int limitPerson;
  final int totalPerson;
  Class({
    @required this.id, 
    @required this.title, 
    @required this.detail, 
    @required this.beginDateTime, 
    @required this.endDateTime,
    @required this.createdTime,
    @required this.updatedTime,
    @required this.imageId, 
    @required this.owner,
    @required this.limitPerson, 
    @required this.totalPerson, 
  });
}