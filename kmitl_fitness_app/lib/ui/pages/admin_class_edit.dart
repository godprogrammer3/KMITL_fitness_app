import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

class AdminClassEdit extends StatelessWidget {
  final Class class_;
  final User user;
  AdminClassEdit({Key key, this.class_, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminClassEditChild(class_: class_, user: user);
  }
}

class AdminClassEditChild extends StatefulWidget {
  final Class class_;
  final User user;
  const AdminClassEditChild({Key key, this.class_, this.user})
      : super(key: key);
  @override
  _AdminClassEditChildState createState() =>
      _AdminClassEditChildState(class_: class_, user: user);
}

class _AdminClassEditChildState extends State<AdminClassEditChild> {
  final Class class_;
  final User user;
  ClassModel classModel;
  File _image;
  TextEditingController _title = TextEditingController(),
      _description = TextEditingController();
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);

  _AdminClassEditChildState({this.user, this.class_});

  bool maxPicked = false;
  int _currentMax = 1;
  NumberPicker maxPicker;

  void _initializeNumberPickers() {
    maxPicker = NumberPicker.integer(
        initialValue: _currentMax,
        minValue: 1,
        maxValue: 20,
        step: 1,
        onChanged: (value) => setState(() => _currentMax = value));
  }

  Future _showMaxPickerDialog() async {
    final number = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.integer(
          highlightSelectedValue: true,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.orange[900]),
            borderRadius: BorderRadius.circular(20),
          ),
          minValue: 1,
          maxValue: 20,
          step: 1,
          initialIntegerValue: _currentMax,
        );
      },
    );
    if (number != null) {
      setState(() {
        _currentMax = number;
        maxPicked = true;
      });
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: (context),
      initialTime: startTime,
    );

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
  void initState() {
    super.initState();
    classModel = ClassModel(uid: user.uid);
    if (class_ != null) {
      _title.text = class_.title;
      _description.text = class_.detail;
      startTime = TimeOfDay.fromDateTime(class_.beginDateTime);
      endTime = TimeOfDay.fromDateTime(class_.endDateTime);
      _currentMax = class_.limitPerson;
    }
    _initializeNumberPickers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: getImage,
                              child: _showImage(context),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.add_photo_alternate, size: 70),
                        color: Colors.white,
                        onPressed: getImage,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 20, left: 30, right: 30, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 0,
                            child: Container(
                              height: 70,
                              child: TextField(
                                maxLength: 20,
                                maxLines: 1,
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
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                          MaterialCommunityIcons.clock_outline),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'เวลาเริ่ม: ' +
                                            startTime.format(context),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Kanit',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(MaterialCommunityIcons
                                          .clock_check_outline),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'เวลาสิ้นสุด: ' +
                                            endTime.format(context),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Kanit',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              RaisedButton(
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
                                padding: EdgeInsets.all(10),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'จำนวนรับสูงสุด: ' +
                                    (maxPicked || class_ != null
                                        ? _currentMax.toString()
                                        : 'โปรดระบุ'),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                              RaisedButton(
                                child: Text(
                                  'เปลี่ยน',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                color: Colors.orange[900],
                                onPressed: () {
                                  _showMaxPickerDialog();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(10),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: TextField(
                              maxLength: 200,
                              maxLines: 2,
                              controller: _description,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
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
                            child: (class_ != null)
                                ? RaisedButton(
                                    onPressed: () async {
                                      final nowTime = DateTime.now();
                                      Map<String, dynamic> data = {
                                        'title': _title.text,
                                        'detail': _description.text,
                                        'beginDateTime': DateTime(
                                            nowTime.year,
                                            nowTime.month,
                                            nowTime.day,
                                            startTime.hour,
                                            startTime.minute),
                                        'endDateTime': DateTime(
                                            nowTime.year,
                                            nowTime.month,
                                            nowTime.day,
                                            endTime.hour,
                                            endTime.minute),
                                        'limitPerson': _currentMax,
                                      };
                                      await classModel.updateClass(
                                          class_.id, data, _image);
                                      print('updated class complete');
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.orange[900],
                                    child: Container(
                                      height: 25,
                                      width: 200,
                                      child: Text(
                                        'บันทึก',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: 'Kanit'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                  )
                                : RaisedButton(
                                    onPressed: () async {
                                      final nowTime = DateTime.now();
                                      Map<String, dynamic> data = {
                                        'title': _title.text,
                                        'detail': _description.text,
                                        'beginDateTime': DateTime(
                                            nowTime.year,
                                            nowTime.month,
                                            nowTime.day,
                                            startTime.hour,
                                            startTime.minute),
                                        'endDateTime': DateTime(
                                            nowTime.year,
                                            nowTime.month,
                                            nowTime.day,
                                            endTime.hour,
                                            endTime.minute),
                                        'limitPerson': _currentMax,
                                      };
                                      await classModel.creatClass(data, _image);
                                      print('create class complete');
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.orange[900],
                                    child: Container(
                                      height: 25,
                                      width: 200,
                                      child: Text(
                                        'สร้างคลาส',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: 'Kanit'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _showImage(BuildContext context) {
    if (class_ != null) {
      return Container(
          height: 240,
          color: Colors.black38,
          child: _image == null
              ? FutureBuilder(
                  future:
                      ClassModel(uid: user.uid).getUrlFromImageId(class_.id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: LoadingWidget(height: 50, width: 50));
                    } else if (snapshot.data == null) {
                      return Center(
                          child: LoadingWidget(height: 50, width: 50));
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          snapshot.data,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    }
                  },
                )
              : Image.file(_image));
    } else {
      return Container(
          height: 240,
          color: Colors.black38,
          child: _image == null ? null : Image.file(_image));
    }
  }
}
