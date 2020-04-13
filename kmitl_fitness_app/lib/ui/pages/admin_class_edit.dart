import 'package:flutter/material.dart';

class AdminClassEdit extends StatelessWidget {
  const AdminClassEdit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminClassEditChild();
  }
}

class AdminClassEditChild extends StatefulWidget {
  @override
  _AdminClassEditChildState createState() => _AdminClassEditChildState();
}

class _AdminClassEditChildState extends State<AdminClassEditChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Class'),
      ),
    );
  }
}
