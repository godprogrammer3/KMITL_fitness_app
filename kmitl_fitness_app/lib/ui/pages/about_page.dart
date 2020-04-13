import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AboutPage extends StatelessWidget {
  final User user;
  const AboutPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutPageChild();
  }
}

class AboutPageChild extends StatefulWidget {
  final User user;
  const AboutPageChild({Key key, this.user}) : super(key: key);

  @override
  _AboutPageChildState createState() => _AboutPageChildState();
}

class _AboutPageChildState extends State<AboutPageChild> {
  final User user;
  _AboutPageChildState({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/flutter.jpg'),
              radius: 75,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'KMITL Fitness Center App',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'About us...',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: 300,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
