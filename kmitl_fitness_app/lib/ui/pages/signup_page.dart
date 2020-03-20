import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignupPageChild();
  }
}


class SignupPageChild extends StatelessWidget {
  const SignupPageChild({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 80.0,),
                Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.orange[900],
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              ),
                SizedBox(height: 40.0,),

                Container(width: 250, height: 50, child: TextField(
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
                )),

                SizedBox(height: 20.0,),

                Container(width: 250, height: 50, child: TextField(
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
                )),

                SizedBox(height: 20.0,),

                Container(width: 250, height: 50, child: TextField(
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
                )),

                SizedBox(height: 20.0,),

                Container(width: 250, height: 50, child: TextField(
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
                )),

                SizedBox(height: 20.0,),

                Container(width: 250, height: 50, child: TextField(
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
                )),

                SizedBox(height: 30.0,),



               Container(
                width: 300,
                height: 50,
                child: FlatButton(
                    onPressed: () {
                      print("sign up complete");
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

               SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Have an account ?,"),
                  FlatButton(
                    onPressed: () {},
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
          ));
  }
}