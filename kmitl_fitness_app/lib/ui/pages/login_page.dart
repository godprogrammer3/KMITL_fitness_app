import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.orange[900],
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Email Address',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: _toggleVisibility,
                      icon: _isHidden
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  obscureText: _isHidden,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 50,
                child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.transparent)),
                    color: Colors.orange[900],
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "or",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 120,
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 50,
                child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.transparent)),
                    color: Colors.blue[900],
                    child: Text(
                      "LOGIN WITH FACEBOOK",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account ?"),
                  FlatButton(
                    onPressed: () {},
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      "SIGN UP",
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
    );
  }
}
