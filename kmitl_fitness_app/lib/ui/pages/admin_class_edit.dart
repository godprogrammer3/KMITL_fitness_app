import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminClassEdit extends StatelessWidget {
  const AdminClassEdit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminClassEditChild();
  }
}

class AdminClassEditChild extends StatefulWidget {
  @override
  _AdminClassEditChildState createState() => _AdminClassEditChildState();
}

class _AdminClassEditChildState extends State<AdminClassEditChild> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('_image: $_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: getImage,
                        child: Container(
                            height: 240,
                            color: Colors.black38,
                            child: _image == null
                                ? Icon(
                                    Icons.add_photo_alternate,
                                    size: 70,
                                    color: Colors.white,
                                  )
                                : Image.file(_image)),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
