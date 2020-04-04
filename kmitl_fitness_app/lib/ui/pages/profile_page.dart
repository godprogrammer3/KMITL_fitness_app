import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfilePageChild();
  }
}

class ProfilePageChild extends StatefulWidget {
  @override
  _ProfilePageStateChild createState() => _ProfilePageStateChild();
}

class _ProfilePageStateChild extends State<ProfilePageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => {},
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.orange[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.account_circle,size: 125,),
            ),
            Text(
              "Membership until 02/02/20",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.stars,size:30,color: Colors.orange[900],),
                Text(
                  "300",
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 25,
                  ),
                )
              ],
            ),
            FlatButton(
              onPressed: () => {},
              child: Text(
                "Reward",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15
                )
              ),
            ),
            FlatButton(
              onPressed: () => {},
              child: Text(
                "Membership",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15
                )
              ),
            ),
            FlatButton(
              onPressed: () => {},
              child: Text(
                "Password",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15
                )
              ),
            ),
            FlatButton(
              onPressed: () => {},
              child: Text(
                "About",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15
                )
              ),
            ),
            FlatButton(
              onPressed: () => {},
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15
                )
              ),
            ),
          ],
        )
      ),
    );
  }
}
