import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/membership_page.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminPasswordPage extends StatelessWidget {
  final User user;
  AdminPasswordPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminPasswordPageChild(user: user);
  }
}

class AdminPasswordPageChild extends StatefulWidget {
  final User user;
  const AdminPasswordPageChild({Key key, this.user}) : super(key: key);
  @override
  _AdminPasswordPageStateChild createState() =>
      _AdminPasswordPageStateChild(user: user);
}

class _AdminPasswordPageStateChild extends State<AdminPasswordPageChild> {
  final authenModel = AuthenModel();
  final User user;

  _AdminPasswordPageStateChild({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
              width: 250,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Current Password",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                obscureText: true,
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 250,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "New Password",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                obscureText: true,
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 250,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "New Password, again",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                obscureText: true,
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.orange[900],
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: FlatButton(
                onPressed: () async {
                  final databaseModel = DatabaseModel(uid: user.uid);
                  await databaseModel.updateUserData({'fcmToken': ''});
                  await authenModel.signOut();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  'Return',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      )),
    );
  }
}
