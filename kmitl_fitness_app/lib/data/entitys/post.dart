import 'package:flutter/foundation.dart';

class Post{
  final String id;
  final String title;
  final String imageId;
  final String detail;
  final String owner;
  final DateTime createdTime;
  final DateTime updatedTime;
  Post({
    @required this.id, 
    @required this.title, 
    @required this.imageId, 
    @required this.detail, 
    @required this.owner, 
    @required this.createdTime, 
    @required this.updatedTime
  });
}