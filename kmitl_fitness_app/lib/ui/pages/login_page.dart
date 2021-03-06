import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPageChild();
  }
}

class LoginPageChild extends StatefulWidget {
  @override
  _LoginPageStateChild createState() => _LoginPageStateChild();
}

class _LoginPageStateChild extends State<LoginPageChild> {
  bool _isHidden = true;
  bool _isLoading = false;
  AuthenModel authenModel = AuthenModel();
  TextEditingController email = TextEditingController(),
      password = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    if (email != null) {
      email.dispose();
    }
    if (password != null) {
      password.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: LoadingOverlay(
                isLoading: _isLoading,
                child: Form(
                  key: _formKey,
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
                        height: 80,
                        child: TextFormField(
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
                          controller: email,
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        height: 80,
                        child: TextFormField(
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
                          controller: password,
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        child: Builder(
                          builder: (BuildContext context) => FlatButton(
                              onPressed: () async {
                                if (!_formKey.currentState.validate()) {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Please fill up the form correctly"),
                                    backgroundColor: Colors.red,
                                  ));
                                  return;
                                }
                                email.text = email.text.trimRight();
                                if (email.text == '' || password.text == '') {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Email Address or Password field is empty."),
                                    backgroundColor: Colors.red,
                                  ));
                                  return;
                                }
                                setState(() => _isLoading = true);
                                final user = await authenModel
                                    .signInWithEmailAndPassword(
                                        email.text, password.text);
                                if (this.mounted) {
                                  setState(() => _isLoading = false);
                                }
                                if (user == null) {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Sorry incorrect email or password, please try again"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(color: Colors.transparent)),
                              color: Colors.orange[900],
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
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
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              final result =
                                  await authenModel.loginWithGoogle();
                              if (this.mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              } else {
                                _isLoading = false;
                              }
                              if (result == 0) {
                                print('login with google success');
                              } else {
                                print('login with google failed');
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Log in with google account failed!"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(color: Colors.grey)),
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/google_logo.png',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          Container(
                            width: 60,
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ));
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
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
        ),
      ),
    );
  }
}
