import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TestPageChild();
  }
}

class TestPageChild extends StatelessWidget {
  TestPageChild({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Center(
        child: RaisedButton(
            onPressed: () async {
              print('dialog shown');
            },
            child: Text('show dialog')),
      ),
    );
  }
}
