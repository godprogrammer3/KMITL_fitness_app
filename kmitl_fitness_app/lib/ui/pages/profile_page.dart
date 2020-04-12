import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/membership_page.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  ProfilePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfilePageChild(user: user);
  }
}

class ProfilePageChild extends StatefulWidget {
  final User user;
  const ProfilePageChild({Key key, this.user}) : super(key: key);
  @override
  _ProfilePageStateChild createState() => _ProfilePageStateChild(user: user);
}

class _ProfilePageStateChild extends State<ProfilePageChild> {
  final authenModel = AuthenModel();
  final User user;

  _ProfilePageStateChild({this.user});
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
            child: Icon(
              Icons.account_circle,
              size: 125,
            ),
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
              Icon(
                Icons.stars,
                size: 30,
                color: Colors.orange[900],
              ),
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
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return PointPage();
              }));
            },
            child: Text("Reward",
                style: TextStyle(color: Colors.grey[900], fontSize: 15)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return MembershipPage();
              }));
            },
            child: Text("Membership",
                style: TextStyle(color: Colors.grey[900], fontSize: 15)),
          ),
          FlatButton(
            onPressed: () => {},
            child: Text("Password",
                style: TextStyle(color: Colors.grey[900], fontSize: 15)),
          ),
          FlatButton(
            onPressed: () => {},
            child: Text("About",
                style: TextStyle(color: Colors.grey[900], fontSize: 15)),
          ),
          FlatButton(
            onPressed: () async {
              final databaseModel = DatabaseModel(uid: user.uid);
              await databaseModel.updateUserData({'fcmToken': ''});
              await authenModel.signOut();
            },
            child: Text("Logout",
                style: TextStyle(color: Colors.red, fontSize: 15)),
          ),
        ],
      )),
    );
  }
}
