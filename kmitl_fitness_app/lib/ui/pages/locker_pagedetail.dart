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
          color: Colors.orange[900],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your locker is UNLOCKED",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.lock_open,size: 100,),
            ),
            SizedBox(height: 20,),
            Container(
              width: 200,
              height: 50,
                child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.transparent)),
                    color: Colors.grey[800],
                    child: Text(
                      "Close",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
            )
          ],
        ),
      ),
    );
  }
}
