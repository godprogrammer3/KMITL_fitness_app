import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

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
      appBar: AppBar(
        title: Text(
          'Locker',
          style: TextStyle(color: Colors.orange[900]),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.orange[900],
          )
        ],
      ),
      body: Center(child: Text('Locker')),
    );
  }
}
