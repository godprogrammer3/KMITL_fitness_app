import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_class_edit.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_class_participants.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AdminClassDetail extends StatelessWidget {
  final User user;
  final Class class_;
  AdminClassDetail({Key key, this.user, this.class_}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdminClassDetailChild(user: user, class_: class_);
  }
}

class AdminClassDetailChild extends StatefulWidget {
  final User user;
  final Class class_;

  const AdminClassDetailChild({Key key, this.user, this.class_})
      : super(key: key);
  @override
  _AdminClassDetailChildState createState() =>
      _AdminClassDetailChildState(user: user, class_: class_);
}

class _AdminClassDetailChildState extends State<AdminClassDetailChild> {
  final User user;
  final Class class_;
  _AdminClassDetailChildState({this.user, this.class_});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(
            future: ClassModel(uid: user.uid).getUrlFromImageId(class_.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: LoadingWidget(height: 50, width: 50));
              } else if (snapshot.data == null) {
                return Center(child: LoadingWidget(height: 50, width: 50));
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
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  class_.title,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'เวลา: ' +
                      DateFormat('kk:mm').format(class_.beginDateTime) +
                      ' - ' +
                      DateFormat('kk:mm').format(class_.endDateTime) +
                      ' น.',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Kanit',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              //color: Colors.black54,
              child: Text(
                class_.detail,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Kanit',
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AdminClassParticipants(user: user, class_: class_),
                  ));
                },
                color: Colors.orange[900],
                child: Container(
                  height: 25,
                  width: 200,
                  child: Text(
                    'รายชื่อผู้เข้าร่วม',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, fontFamily: 'Kanit'),
                    textAlign: TextAlign.center,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AdminClassEdit(user: user, class_: class_),
                  ));
                },
                color: Colors.blue,
                child: Container(
                  height: 25,
                  width: 100,
                  child: Text(
                    'แก้ไข',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, fontFamily: 'Kanit'),
                    textAlign: TextAlign.center,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),
              RaisedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 20,
                      title: Text(
                        'ลบคลาส?',
                        style: TextStyle(fontSize: 30, fontFamily: 'Kanit'),
                      ),
                      content: Text(
                        'คุณแน่ใจหรือไม่ที่จะทำการลบคลาส ' + class_.title,
                        style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            'ไม่',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Kanit',
                                color: Colors.black54),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'ใช่',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Kanit',
                                color: Colors.orange[900]),
                          ),
                          onPressed: () async {
                            final result = await ClassModel(uid: user.uid)
                                .deleteClass(class_.id);
                            if (result == 0) {
                              print('delete class success');
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            } else {
                              print('delete class faild');
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
                color: Colors.red,
                child: Container(
                  height: 25,
                  child: Text(
                    'ลบ',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, fontFamily: 'Kanit'),
                    textAlign: TextAlign.center,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
