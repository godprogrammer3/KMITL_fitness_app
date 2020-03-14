import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class LockerPage2 extends StatelessWidget {
  const LockerPage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LockerPage2Child();
  }
}

class LockerPage2Child extends StatefulWidget {
  @override
  _LockerPage2StateChild createState() => _LockerPage2StateChild();
}

class _LockerPage2StateChild extends State<LockerPage2Child> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black,
        ),
        title: Text(
          'Locker2',
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
