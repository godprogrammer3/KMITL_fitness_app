import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignupPageChild();
  }
}


class SignupPageChild extends StatelessWidget {
  final authenModel = AuthenModel();
  final firstName = TextEditingController(),lastName = TextEditingController(), email = TextEditingController(),password = TextEditingController();
  SignupPageChild({Key key}) : super(key: key);

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
                  controller: firstName,
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
                  controller: lastName,
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
                  controller:email,
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
                  obscureText: true,
                  controller: password,
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
                  obscureText: true,
                )),

                SizedBox(height: 40.0,),



                RaisedButton(


                  onPressed: () async {
                     final userData = UserData(firstName:firstName.text,lastName:lastName.text, email: email.text);
                     final user = await authenModel.register(userData, password.text);
                      if(user == null){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Sorry can't create account please try again."),
                          backgroundColor: Colors.red,
                        ));
                      }
                  },

                  color: Colors.deepOrangeAccent,
                  child: Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ));
  }
}