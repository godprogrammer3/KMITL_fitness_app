import 'package:flutter/foundation.dart';

class Post{
  final String id;
  final String title;
  final String imageUrl;
  final String detail;
  final String owner;
  final DateTime createdTime;
  final DateTime updatedTime;
  Post({
    @required this.id, 
    @required this.title, 
    @required this.imageUrl, 
    @required this.detail, 
    @required this.owner, 
    @required this.createdTime, 
    @required this.updatedTime
  });
}