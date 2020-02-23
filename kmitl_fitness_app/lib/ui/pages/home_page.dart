import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageChild();
  }
}

class HomePageChild extends StatefulWidget {
  @override
  _HomePageStateChild createState() => _HomePageStateChild();
}

class _HomePageStateChild extends State<HomePageChild> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.orange[900],
          )
        ],
      ),
      body: Center(child: Text('Home')),
    );
  }
}
