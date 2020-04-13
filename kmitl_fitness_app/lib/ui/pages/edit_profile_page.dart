import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

String _name = 'John';
String _lastName = 'Wick';
String _email = 'johnwick123@gmail.com';
String _phoneNumber = '0972340683';
String _birthDay = '09/02/1964';
File imageFile;

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditProfilePageChild();
}

class EditProfilePageChild extends State<EditProfilePage> {
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: _name,
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      initialValue: _lastName,
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

  Widget _buildEmail() {
    return TextFormField(
      initialValue: _email,
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

  Widget _buildPhoneNumber() {
    return TextFormField(
      initialValue: _phoneNumber,
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

  Widget _buildBirthDay() {
    return TextFormField(
      initialValue: _birthDay,
      decoration: InputDecoration(labelText: 'Birth Day (mm/dd/yyyy)'),
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
        _birthDay = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: (Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        )),
        backgroundColor: Colors.orange[900],
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
        child: Container(
            width: 270,
            margin: EdgeInsets.all(24),
            child: Form(
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
                              child: (imageFile != null)
                                  ? Image.file(imageFile, fit: BoxFit.fill)
                                  : Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                            ),
                          )),
                    ),
                    SizedBox(height: 10.0),
                    _buildName(),
                    SizedBox(height: 10.0),
                    _buildLastName(),
                    SizedBox(height: 10.0),
                    _buildEmail(),
                    SizedBox(height: 10.0),
                    _buildPhoneNumber(),
                    SizedBox(height: 10.0),
                    _buildBirthDay(),
                    SizedBox(height: 20.0),
                    FlatButton(
                        color: Colors.orange[900],
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          _formKey.currentState.save();

                          print(_name);
                          print(_lastName);
                          print(_email);
                          print(_phoneNumber);
                          print(_birthDay);
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
                            side: BorderSide(color: Colors.transparent)))
                  ],
                ))),
      ))),
    );
  }
}
