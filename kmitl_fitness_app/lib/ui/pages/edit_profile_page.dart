import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditProfilePageChild();
  }
}

class EditProfilePageChild extends State<EditProfilePage> {
  String _name;
  String _lastName;
  String _email;
  String _phoneNumber;
  String _birthDay;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),  
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        if (!RegExp(r"^[a-z]{1,10}$").hasMatch(value)) {
          return 'Please enter a valid Name';
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
      decoration: InputDecoration(labelText: 'Last Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required';
        }

        if (!RegExp(r"^[a-z']{2,10}$").hasMatch(value)) {
          return 'Please enter a valid Last Name';
        }

        return null;
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
    ;
  }

  Widget _buildEmail() {
    return TextFormField(
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
      decoration: InputDecoration(labelText: 'Birth Day (dd/mm/yyyy)'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Birth Day is Required';
        }

        if (!RegExp(r"^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d$" ).hasMatch(value)) {
          return 'Please enter a valid Birth Day';
        }

        return null;
      },
      onSaved: (String value) {
        _birthDay = value;
      },
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
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
              child: Container(
                  margin: EdgeInsets.all(24),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.account_circle,
                              size: 125,
                            ),
                          ),
                          _buildName(),
                          _buildLastName(),
                          _buildEmail(),
                          _buildPhoneNumber(),
                          _buildBirthDay(),
                        ],
                      ))))),
    );
  }
}
