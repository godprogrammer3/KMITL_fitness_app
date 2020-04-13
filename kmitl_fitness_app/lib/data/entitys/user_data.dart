class UserData {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime membershipExpireDate;
  final int point;
  final int birthYear;
  final String role;
  final String faceId;
  final bool isHaveYellowCard;
  UserData(
      {this.point,
      this.birthYear,
      this.role,
      this.faceId,
      this.isHaveYellowCard,
      this.firstName,
      this.lastName,
      this.email,
      this.uid,
      this.membershipExpireDate});
}
