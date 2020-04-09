import 'package:flutter/foundation.dart';

class TreadmillQueue implements Comparable{
  final int queueNumber;
  final String firstName;
  final String user;
  TreadmillQueue({
    @required this.queueNumber,
    @required this.firstName, 
    @required this.user, 
  });
  @override
  int compareTo(other) {
    if (this.queueNumber == null || other == null) {
      return null;
    }

    if (this.queueNumber < other.queueNumber) {
      return -1;
    }

    if (this.queueNumber > other.queueNumber) {
      return 1;
    }

    if (this.queueNumber == other.queueNumber) {
      return 0;
    }
    return null;
  }
}