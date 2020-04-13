import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/membership_page.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminProfilePage extends StatelessWidget {
  final User user;
  AdminProfilePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminProfilePageChild(user: user);
  }
}

class AdminProfilePageChild extends StatefulWidget {
  final User user;
  const AdminProfilePageChild({Key key, this.user}) : super(key: key);
  @override
  _AdminProfilePageStateChild createState() =>
      _AdminProfilePageStateChild(user: user);
}

class _AdminProfilePageStateChild extends State<AdminProfilePageChild> {
  final authenModel = AuthenModel();
  final User user;

  _AdminProfilePageStateChild({this.user});
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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AdminPasswordPage(),
              ));
            },
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.orange[900],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.account_circle,
              size: 125,
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Admin",
                style: TextStyle(color: Colors.black, fontSize: 35)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AdminPasswordPage(),
              ));
            },
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
