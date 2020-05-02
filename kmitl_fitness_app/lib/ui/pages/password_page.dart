import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';

class PasswordPage extends StatelessWidget {
  final User user;
  PasswordPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PasswordPageChild(user: user);
  }
}

class PasswordPageChild extends StatefulWidget {
  final User user;
  const PasswordPageChild({Key key, this.user}) : super(key: key);
  @override
  _PasswordPageStateChild createState() =>
      _PasswordPageStateChild(user: user);
}

class _PasswordPageStateChild extends State<PasswordPageChild> {
  final authenModel = AuthenModel();
  final User user;
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confiremNewPasswordController =
      TextEditingController();
  _PasswordPageStateChild({this.user});
  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confiremNewPasswordController.dispose();
    super.dispose();
  }

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
                controller: _currentPasswordController,
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
                controller: _newPasswordController,
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
                  hintText: "Confirm new password",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                obscureText: true,
                controller: _confiremNewPasswordController,
              )),
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
                  final userData = await UserModel(uid: user.uid).getUserData();
                  final resultUser = await AuthenModel()
                      .signInWithEmailAndPassword(
                          userData.email, _currentPasswordController.text);
                  if (resultUser != null) {
                    try {
                      await resultUser
                          .updatePassword(_newPasswordController.text);
                      print('change password success');
                      Navigator.of(context).pop();
                    } catch (error) {
                      print('change password failed');
                    }
                  } else {
                    print('change password failed');
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  'Save',
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
