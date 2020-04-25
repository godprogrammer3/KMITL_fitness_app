import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignupPageChild();
  }
}

class SignupPageChild extends StatefulWidget {
  SignupPageChild({Key key}) : super(key: key);

  @override
  _SignupPageChildState createState() => _SignupPageChildState();
}

class _SignupPageChildState extends State<SignupPageChild> {
  final authenModel = AuthenModel();

  final firstName = TextEditingController(),
      lastName = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: LoadingOverlay(
            isLoading: _isLoading,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.orange[900],
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                      width: 280,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "First Name",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        controller: firstName,
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                      width: 280,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "Last Name",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        controller: lastName,
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                      width: 280,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email Address",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        controller: email,
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                      width: 280,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password (6 or more characters)",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        obscureText: true,
                        controller: password,
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                      width: 280,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Confirm Password",
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
                  IconButton(
                      icon: Icon(Icons.center_focus_weak),
                      iconSize: 80,
                      onPressed: () {}),
                  Text("Add Face ID"),
                  SizedBox(height: 20),
                  Container(
                    width: 280,
                    height: 50,
                    child: Builder(
                      builder: (BuildContext context) => FlatButton(
                          onPressed: () async {
                            final userData = UserData(
                                firstName: firstName.text,
                                lastName: lastName.text,
                                email: email.text);
                            setState(() => _isLoading = true);
                            dynamic user = await authenModel.register(
                                userData, password.text);
                            if (this.mounted) {
                              setState(() => _isLoading = false);
                            }
                            if (user != null) {
                              Navigator.of(context).pop();
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Sorry can't create account please try again."),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(color: Colors.transparent)),
                          color: Colors.orange[900],
                          child: Text(
                            "CREATE ACCOUNT",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Have an account ?,"),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
