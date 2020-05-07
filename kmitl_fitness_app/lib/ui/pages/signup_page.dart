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
  bool _isHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
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
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.orange[900],
                              fontSize: 60,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                            width: 280,
                            height: 77,
                            child: TextFormField(
                              maxLength: 30,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
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
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'First name is required';
                                } else if (value.length < 2 ||
                                    value.length > 30) {
                                  return 'First name must be between 2 and 30 letters';
                                } else if (!RegExp(r"^[\u0E00-\u0E7Fa-zA-Z]+$")
                                    .hasMatch(value)) {
                                  return 'First name must contain only letters';
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                            width: 280,
                            height: 77,
                            child: TextFormField(
                              maxLength: 30,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
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
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Last name is required';
                                } else if (value.length < 2 ||
                                    value.length > 30) {
                                  return 'Last name must be between 2 and 30 letters';
                                } else if (!RegExp(r"^[\u0E00-\u0E7Fa-zA-Z]+$")
                                    .hasMatch(value)) {
                                  return 'Last name must contain only letters';
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                            width: 280,
                            height: 77,
                            child: TextFormField(
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
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Email is Required';
                                }
                                if (!RegExp(
                                        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid Email Address';
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                            width: 280,
                            height: 77,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isHidden = !_isHidden;
                                    });
                                  },
                                  icon: _isHidden
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              obscureText: _isHidden,
                              controller: password,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 8) {
                                  return 'Password must contains at least 8 characters';
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                            width: 280,
                            height: 77,
                            child: TextFormField(
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
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Confirm password is required';
                                }
                                if (value != password.text) {
                                  return 'Passwords do not match, try again';
                                }
                                return null;
                              },
                            )),
                        SizedBox(height: 10),
                        Container(
                          width: 280,
                          height: 50,
                          child: Builder(
                            builder: (BuildContext context) => FlatButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    final userData = UserData(
                                      firstName: firstName.text,
                                      lastName: lastName.text,
                                      email: email.text,
                                      birthDate: null,
                                      faceId: null,
                                      imageId: null,
                                      isHaveYellowCard: null,
                                      membershipExpireDate: null,
                                      point: null,
                                      role: null,
                                      uid: null,
                                      phoneNumber: null,
                                      type: 'email',
                                      discount: -1.0,
                                      statusInFitness: 'out',
                                    );
                                    setState(() => _isLoading = true);
                                    try {
                                      dynamic user = await authenModel.register(
                                          userData, password.text);
                                      if (this.mounted) {
                                        setState(() => _isLoading = false);
                                      }
                                      if (user != null) {
                                        Navigator.of(context).pop();
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Sorry can't create account please try again."),
                                          backgroundColor: Colors.red,
                                        ));
                                        return;
                                      }
                                    } catch (error) {
                                      if (this.mounted) {
                                        setState(() => _isLoading = false);
                                      }
                                      print(error);
                                      if (error.toString() ==
                                          'Exception: ERROR_EMAIL_ALREADY_IN_USE') {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "This Email has been taken by another account."),
                                          backgroundColor: Colors.red,
                                        ));
                                        return;
                                      }
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Sorry can't create account please try again."),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          "Please fill up the form correctly"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side:
                                        BorderSide(color: Colors.transparent)),
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
                            Text("Already have an account?"),
                            Container(
                              width: 50,
                              child: RawMaterialButton(
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
        ));
  }
}
