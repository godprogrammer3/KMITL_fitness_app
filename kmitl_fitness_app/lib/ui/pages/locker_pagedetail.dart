import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class LockerPageDetail extends StatelessWidget {
  const LockerPageDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LockerPageDetailChild();
  }
}

class LockerPageDetailChild extends StatefulWidget {
  @override
  _LockerPageDetailStateChild createState() => _LockerPageDetailStateChild();
}

class _LockerPageDetailStateChild extends State<LockerPageDetailChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black,
        ),
        title: Text(
          'LockerDetail',
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
      body: Center(
        
      ),
    );
  }
}
