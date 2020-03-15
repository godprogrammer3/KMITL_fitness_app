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
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            title: Center(
              child: Text("SIGN UP", style: TextStyle(fontSize: 30),),
            ),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 60.0,),

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

                SizedBox(height: 30.0,),

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

                SizedBox(height: 30.0,),

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

                SizedBox(height: 30.0,),

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

                SizedBox(height: 30.0,),

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

                SizedBox(height: 40.0,),



                RaisedButton(


                  onPressed: () {
                    print("sign up complete");
                  },

                  color: Colors.deepOrangeAccent,
                  child: Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ));
  }
}