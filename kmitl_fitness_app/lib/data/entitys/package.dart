import 'package:flutter/foundation.dart';

class Package {
  final String id;
  final String title;
  final String detail;
  final double price;
  final double pricePerDay;
  final DateTime createdTime;
  final DateTime updatedTime;
  final String owner;
  Package({
    @required this.id,
    @required this.title,
    @required this.detail,
    @required this.price,
    @required this.pricePerDay,
    @required this.createdTime,
    @required this.updatedTime,
    @required this.owner,
  });
}
