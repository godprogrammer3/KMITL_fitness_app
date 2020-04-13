import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  TextEditingController _title, _description;
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: (context), initialTime: startTime);

    if (picked != null && picked != startTime) {
      print('Start Time: ${picked.format(context)}');
      setState(() {
        startTime = picked;
      });
    }
    final TimeOfDay picked2 =
        await showTimePicker(context: (context), initialTime: endTime);

    if (picked2 != null && picked2 != endTime) {
      print('Start Time: ${picked2.format(context)}');
      setState(() {
        endTime = picked2;
      });
    }
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                margin: EdgeInsets.only(top: 20, left: 30),
                height: 60,
                width: 300,
                child: TextField(
                  controller: _title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Kanit',
                  ),
                  decoration: InputDecoration(
                    labelText: 'ชื่อคลาส',
                    labelStyle: TextStyle(fontFamily: 'Kanit'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 35, top: 15, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'เวลาเริ่ม: ' + startTime.format(context),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Kanit',
                          ),
                        ),
                        Text(
                          'เวลาสิ้นสุด: ' + endTime.format(context),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Text(
                        'เลือกเวลา',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      color: Colors.orange[900],
                      onPressed: () {
                        selectTime(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(15),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 30),
                height: 115,
                width: 350,
                child: TextField(
                  maxLines: 3,
                  controller: _description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Kanit',
                  ),
                  decoration: InputDecoration(
                    labelText: 'รายละเอียด',
                    labelStyle: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Center(
                child: FlatButton(
                  onPressed: () {},
                  color: Colors.orange[900],
                  child: Container(
                    height: 25,
                    width: 200,
                    child: Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
