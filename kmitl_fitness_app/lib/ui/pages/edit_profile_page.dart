import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => EditProfilePageChild(user: user);
}

class EditProfilePageChild extends State<EditProfilePage> {
  final User user;
  UserModel userModel;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EditProfilePageChild({this.user});
  String _firstName;
  String _lastName;
  String _email;
  String _phoneNumber;
  String _birthDate;
  String _currentPassword;
  File imageFile;
  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Profile Picture", textAlign: TextAlign.center),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                InkWell(
                  child: Text(
                    'Gallery',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Text(
                    'Camera',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            )),
          );
        });
  }

  Widget _buildName(String str) {
    return TextFormField(
      initialValue: str,
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

  Widget _buildLastName(String str) {
    return TextFormField(
      initialValue: str,
      decoration: InputDecoration(labelText: 'Last Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

  Widget _buildEmail(String str) {
    return TextFormField(
      initialValue: str,
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid Email Address';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPhoneNumber(String str) {
    return TextFormField(
      initialValue: str ?? '',
      decoration: InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required';
        }

        if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
          return 'Please enter a valid Phone Number';
        }
        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildBirthDay(String str) {
    return TextFormField(
      initialValue: str ?? '',
      decoration: InputDecoration(labelText: 'Birth Day (mm/dd/1yyy)'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Birth Day is Required';
        }

        if (!RegExp(
                r"^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d$")
            .hasMatch(value)) {
          return 'Please enter a valid Birth Day';
        }

        return null;
      },
      onSaved: (String value) {
        _birthDate = value;
      },
    );
  }

  Widget _buildCurrentPassword() {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        initialValue: '',
        decoration: InputDecoration(labelText: 'Current password'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Current password is required';
          }
          return null;
        },
        onSaved: (String value) {
          _currentPassword = value;
        },
        obscureText: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    userModel = UserModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: SingleChildScrollView(
              child: Center(
            child: Container(
              width: 270,
              margin: EdgeInsets.all(24),
              child: FutureBuilder(
                  future: userModel.getUserData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: LoadingWidget(height: 50, width: 50));
                    } else if (snapshot.data == null) {
                      return Center(
                          child: LoadingWidget(height: 50, width: 50));
                    } else {
                      _firstName = snapshot.data.firstName;
                      _lastName = snapshot.data.lastName;
                      _email = snapshot.data.email;
                      _phoneNumber = snapshot.data.phoneNumber ?? '';
                      _birthDate = snapshot.data.birthDate ?? '';
                      return Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  _showChoiceDialog(context);
                                },
                                child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.grey,
                                    child: ClipOval(
                                      child: SizedBox(
                                        width: 180.0,
                                        height: 180.0,
                                        child: (snapshot.data.imageId != null)
                                            ? FutureBuilder(
                                                future:
                                                    userModel.getUrlFromImageId(
                                                        snapshot.data.imageId),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.hasError) {
                                                    return Center(
                                                        child: LoadingWidget(
                                                            height: 50,
                                                            width: 50));
                                                  } else if (snapshot.data ==
                                                      null) {
                                                    return Center(
                                                        child: LoadingWidget(
                                                            height: 50,
                                                            width: 50));
                                                  } else {
                                                    if (imageFile != null) {
                                                      return Image.file(
                                                          imageFile,
                                                          fit: BoxFit.fill);
                                                    } else {
                                                      return Image.network(
                                                        snapshot.data,
                                                        fit: BoxFit.fill,
                                                      );
                                                    }
                                                  }
                                                })
                                            : (imageFile == null)
                                                ? Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 100,
                                                  )
                                                : Image.file(imageFile,
                                                    fit: BoxFit.fill),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 10.0),
                              _buildName(snapshot.data.firstName),
                              SizedBox(height: 10.0),
                              _buildLastName(snapshot.data.lastName),
                              SizedBox(height: 10.0),
                              (snapshot.data.type != 'google')
                                  ? _buildEmail(snapshot.data.email)
                                  : Container(),
                              SizedBox(height: 10.0),
                              _buildPhoneNumber(snapshot.data.phoneNumber),
                              SizedBox(height: 10.0),
                              _buildBirthDay(snapshot.data.birthDate),
                              (snapshot.data.type != 'google')
                                  ? _buildCurrentPassword()
                                  : Container(),
                              SizedBox(height: 20.0),
                              FlatButton(
                                  color: Colors.orange[900],
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      Map<String, dynamic> data = {
                                        'firstName': _firstName,
                                        'lastName': _lastName,
                                        'email': _email,
                                        'phoneNumber': _phoneNumber,
                                        'birthDate': _birthDate,
                                      };
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      if (snapshot.data.type == 'google') {
                                        final result = await userModel
                                            .updateUserData(data, imageFile);
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        if (result == 0) {
                                          print('save user data success');
                                          Navigator.of(context).pop();
                                        } else {
                                          print('save user data failed');
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Save failed please try again"),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                        return;
                                      }

                                      final checkUser = await AuthenModel()
                                          .signInWithEmailAndPassword(
                                              snapshot.data.email,
                                              _currentPassword);
                                      if (checkUser != null) {
                                        if (data['email'] !=
                                            snapshot.data.email) {
                                          await checkUser.updateEmail(_email);
                                        }
                                        final result = await userModel
                                            .updateUserData(data, imageFile);
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        if (result == 0) {
                                          print('save user data success');
                                          Navigator.of(context).pop();
                                        } else {
                                          print('save user data failed');
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Save failed please try again"),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        print('current password invalid');
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Save failed password incorrect"),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    } else {
                                      _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Please fill up the form correctly"),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Colors.transparent)))
                            ],
                          ));
                    }
                  }),
            ),
          )),
        ),
      ),
    );
  }
}
