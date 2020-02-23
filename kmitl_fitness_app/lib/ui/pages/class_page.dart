import 'package:flutter/material.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassPageChild();
  }
}
class ClassPageChild extends StatefulWidget {
  @override
  _ClassPageStateChild createState() => _ClassPageStateChild();
}

class _ClassPageStateChild extends State<ClassPageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Class')),
    );
  }
}