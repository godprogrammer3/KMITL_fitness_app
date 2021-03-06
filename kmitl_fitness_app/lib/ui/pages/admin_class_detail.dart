import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_class_edit.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_class_participants.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _AdminClassDetailChildState({this.user, this.class_});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.orange[900],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: FutureBuilder(
          future: ClassModel(uid: user.uid).getData(class_.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else if (snapshot.data == null) {
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: LoadingOverlay(
                  isLoading: _isLoading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: ClassModel(uid: user.uid)
                            .getUrlFromImageId(snapshot.data.imageId),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                              child: Image(
                                fit: BoxFit.fill,
                                image: CacheImage(snapshot.data),
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
                              snapshot.data.title,
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'kanit'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'เวลา: ' +
                                  DateFormat('kk:mm')
                                      .format(snapshot.data.beginDateTime) +
                                  ' - ' +
                                  DateFormat('kk:mm')
                                      .format(snapshot.data.endDateTime) +
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
                            snapshot.data.detail,
                            style: TextStyle(
                              fontSize: 18,
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
                                builder: (context) => AdminClassParticipants(
                                    user: user, class_: snapshot.data),
                              ));
                            },
                            color: Colors.orange[900],
                            child: Container(
                              height: 25,
                              width: 200,
                              child: Text(
                                'รายชื่อผู้เข้าร่วม',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Kanit'),
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
                                    AdminClassEdit(user: user, class_: snapshot.data),
                              ));
                            },
                            color: Colors.blue,
                            child: Container(
                              height: 25,
                              width: 100,
                              child: Text(
                                'แก้ไข',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Kanit'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              final resultDialog = await showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  elevation: 20,
                                  title: Text(
                                    'ลบคลาส?',
                                    style: TextStyle(
                                        fontSize: 30, fontFamily: 'Kanit'),
                                  ),
                                  content: Text(
                                    'คุณแน่ใจหรือไม่ที่จะทำการลบคลาส ' +
                                        class_.title,
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'Kanit'),
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
                                        Navigator.of(context).pop(-1);
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
                                        Navigator.of(context).pop(0);
                                      },
                                    ),
                                  ],
                                ),
                              );
                              if (resultDialog == 0) {
                                if (user.uid != class_.owner) {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Delete class failed you are not owner"),
                                    backgroundColor: Colors.red,
                                  ));
                                  return;
                                }
                                setState(() {
                                  _isLoading = true;
                                });
                                final result = await ClassModel(uid: user.uid)
                                    .deleteClass(snapshot.data.id);
                                setState(() {
                                  _isLoading = false;
                                });
                                if (result == 0) {
                                  print('delete class success');
                                  Navigator.of(context).pop();
                                } else {
                                  print('delete class faild');
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Delete class failed please try again"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }
                            },
                            color: Colors.red,
                            child: Container(
                              height: 25,
                              child: Text(
                                'ลบ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Kanit'),
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
                ),
              );
            }
          }),
    );
  }
}
