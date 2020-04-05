import 'package:flutter/foundation.dart';

class TreadmillStatus{
  final bool isAvailable;
  final String user;
  TreadmillStatus({
    @required this.isAvailable, 
    @required this.user 
  });
}