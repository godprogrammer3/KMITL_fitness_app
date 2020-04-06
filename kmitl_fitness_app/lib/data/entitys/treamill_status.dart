import 'package:flutter/foundation.dart';

class TreadmillStatus{
  final String id;
  final bool isAvailable;
  final String user;
  TreadmillStatus({
    @required this.id,
    @required this.isAvailable, 
    @required this.user 
  });
}