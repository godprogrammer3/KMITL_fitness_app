import 'package:flutter/material.dart';

class  TreadmillPage extends StatelessWidget {
  const TreadmillPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TreadmillPageChild();
  }
}
class TreadmillPageChild extends StatefulWidget {
  @override
  _TreadmillPageStateChild createState() => _TreadmillPageStateChild();
}

class _TreadmillPageStateChild extends State<TreadmillPageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Treadmill')),
    );
  }
}