import 'package:flutter/material.dart';


class LockerPage extends StatelessWidget {
  const LockerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LockerPageChild();
  }
}
class LockerPageChild extends StatefulWidget {
  @override
  _LockerPageStateChild createState() => _LockerPageStateChild();
}

class _LockerPageStateChild extends State<LockerPageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Locker')),
    );
  }
}