import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfilePageChild();
  }
}

class ProfilePageChild extends StatefulWidget {
  @override
  _ProfilePageStateChild createState() => _ProfilePageStateChild();
}

class _ProfilePageStateChild extends State<ProfilePageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Profile')),
    );
  }
}
