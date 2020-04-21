import 'package:flutter/foundation.dart';

class Locker{
  final String id;
  final bool isLocked;
  final String user;

  Locker({
    @required this.id,
    @required this.isLocked, 
    @required this.user
  });
}