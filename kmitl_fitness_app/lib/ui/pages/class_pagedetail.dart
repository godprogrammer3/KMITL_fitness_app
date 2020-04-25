import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class ClassPageDetail extends StatelessWidget {
  final User user;
  final Class class_;
  ClassPageDetail({Key key, this.user, this.class_}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassPageDetailChild(user: user, class_: class_);
  }
}

class ClassPageDetailChild extends StatefulWidget {
  final User user;
  final Class class_;

  const ClassPageDetailChild({Key key, this.user, this.class_})
      : super(key: key);
  @override
  _ClassPageDetailStateChild createState() =>
      _ClassPageDetailStateChild(user: user, class_: class_);
}

class _ClassPageDetailStateChild extends State<ClassPageDetailChild> {
  final User user;
  final Class class_;
  ClassModel classModel;
  _ClassPageDetailStateChild({this.user, this.class_});
  @override
  void initState() {
    super.initState();
    classModel = ClassModel(uid: user.uid);
  }

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
            future: classModel.getUrlFromImageId(class_.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return LoadingWidget(height: 50, width: 50);
              } else if (snapshot.data == null) {
                return LoadingWidget(height: 50, width: 50);
              } else {
                return Image.network(snapshot.data, fit: BoxFit.cover);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
              class_.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
              'วันที่ ' + DateFormat('dd/MM/yyyy').format(class_.beginDateTime),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child: Text(
              'เวลา 16:00 - 17:00',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
              class_.detail,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Spacer(),
          Center(
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.orange[900],
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: FutureBuilder(
                future: classModel.isReserved(class_.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return LoadingWidget(height: 50, width: 50);
                  } else if (snapshot.data == null) {
                    return LoadingWidget(height: 50, width: 50);
                  } else {
                    return (snapshot.data)
                        ? FlatButton(
                            color: Colors.black,
                            onPressed: () async {
                              //showClassDialog(context);
                              final result =
                                  await classModel.cancelClass(class_.id);
                              if (result == 0) {
                                print('cancel success');
                                Navigator.of(context).pop();
                              } else {
                                print('cancel class failed');
                                print('error code: $result');
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))
                        : FlatButton(
                            onPressed: () async {
                              showClassDialog(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              'Reserve',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ));
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  showClassDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("CANCEL"),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
    );
    Widget continueButton = FlatButton(
      child: Text("CONFIRM"),
      onPressed: () async {
        final result = await classModel.reserveClass(class_.id);
        if (result == 0) {
          print('reserve class success');
          Navigator.of(context, rootNavigator: true).pop();
        } else {
          print('reserve class failed');
          print('error code: $result');
        }
      },
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("Confirm Reservation"),
      content: Text(
          """ยืนยันการจองคลาสนี้ หรือไม่?\nหากท่านไม่มาเข้าคลาสตามที่กำหนดท่านจะถูกติดสถานะใบเหลือง\n\n*สามารถยกเลิกการจองก่อนเริ่มคลาสอย่างน้อย 30 นาที"""),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
