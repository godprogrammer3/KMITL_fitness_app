import 'package:flutter/material.dart';

String _name = 'John';
String _lastName = 'Wick';
String _email = 'johnwick123@gmail.com';
String _phoneNumber = '0972340683';
String _birthDay = '09/02/1964';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditProfilePageChild();
  }
}

class EditProfilePageChild extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
<<<<<<< HEAD
=======
      initialValue: _name,
>>>>>>> edit_profile_page
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
    ;
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
<<<<<<< HEAD
=======
      initialValue: _birthDay,
>>>>>>> edit_profile_page
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
<<<<<<< HEAD
              child: Container(
                  margin: EdgeInsets.all(24),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Center(child: CircleAvatar(radius: 60,backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/en/9/98/John_Wick_TeaserPoster.jpg'),backgroundColor: Colors.grey,)),
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
                        ],
                      ))))),
=======
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
                          print('select image');
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/en/9/98/John_Wick_TeaserPoster.jpg'),
                          backgroundColor: Colors.grey,
                        )),
                    SizedBox(height: 20.0),
                    _buildName(),
                    SizedBox(height: 20.0),
                    _buildLastName(),
                    SizedBox(height: 20.0),
                    _buildEmail(),
                    SizedBox(height: 20.0),
                    _buildPhoneNumber(),
                    SizedBox(height: 20.0),
                    _buildBirthDay(),
                  ],
                ))),
      ))),
>>>>>>> edit_profile_page
    );
  }
}
