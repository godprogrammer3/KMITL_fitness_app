import 'package:flutter/foundation.dart';

class UserData {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime membershipExpireDate;
  final int point;
  final String birthDate;
  final String role;
  final String faceId;
  final bool isHaveYellowCard;
  final String imageId;
  final String phoneNumber;
  final String type;
  final double discount;
  final String statusInFitness;
  UserData(
      {
      @required this.point,
      @required this.birthDate,
      @required this.role,
      @required this.faceId,
      @required this.isHaveYellowCard,
      @required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.uid,
      @required this.membershipExpireDate,
      @required this.imageId,
      @required this.phoneNumber, 
      @required this.type, 
      @required this.discount, 
      @required this.statusInFitness, 
  });
}
