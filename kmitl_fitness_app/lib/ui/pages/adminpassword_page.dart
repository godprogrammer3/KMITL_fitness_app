import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confiremNewPasswordController =
      TextEditingController();
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHidden1 = true;
  bool _isHidden2 = true;
  _AdminPasswordPageStateChild({this.user});
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
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 250,
                    height: 70,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isHidden1 = !_isHidden1;
                            });
                          },
                          icon: _isHidden1
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        hintText: "Current Password",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      obscureText: _isHidden1,
                      controller: _currentPasswordController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'current password is required';
                        }
                        return null;
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 250,
                    height: 70,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isHidden2 = !_isHidden2;
                            });
                          },
                          icon: _isHidden2
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
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
                      obscureText: _isHidden2,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'New password is required';
                        } else if (value.length < 6) {
                          return 'New password must longer than 5 letter';
                        }
                        return null;
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 250,
                    height: 70,
                    child: TextFormField(
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Confirm password is required';
                        } else if (value != _newPasswordController.text) {
                          return 'Confirm password not match';
                        }
                        return null;
                      },
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
                        if (!_formKey.currentState.validate()) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Please fill up the form correctly"),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        final userData =
                            await UserModel(uid: user.uid).getUserData();
                        final resultUser = await AuthenModel()
                            .signInWithEmailAndPassword(userData.email,
                                _currentPasswordController.text);
                        if (resultUser != null) {
                          try {
                            await resultUser
                                .updatePassword(_newPasswordController.text);
                            setState(() {
                              _isLoading = false;
                            });
                            print('change password success');
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Change password success"),
                              backgroundColor: Colors.green,
                            ));
                          } catch (error) {
                            print('change password failed');
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  "Change password failed please try again"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          print(
                              'Change password failed current password incorrect');
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                "Change password failed current password incorrect"),
                            backgroundColor: Colors.red,
                          ));
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
            ),
          )),
        ),
      ),
    );
  }
}
