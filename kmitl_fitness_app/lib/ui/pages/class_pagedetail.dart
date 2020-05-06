import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:cache_image/cache_image.dart';
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

  ClassPageDetailChild({Key key, this.user, this.class_}) : super(key: key);
  @override
  _ClassPageDetailStateChild createState() =>
      _ClassPageDetailStateChild(user: user, class_: class_);
}

class _ClassPageDetailStateChild extends State<ClassPageDetailChild> {
  final User user;
  final Class class_;
  ClassModel classModel;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _ClassPageDetailStateChild({this.user, this.class_});
  @override
  void initState() {
    super.initState();
    classModel = ClassModel(uid: user.uid);
  }

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FutureBuilder(
                  future: classModel.getUrlFromImageId(class_.id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: LoadingWidget(height: 50, width: 50));
                    } else if (snapshot.data == null) {
                      return Center(
                          child: LoadingWidget(height: 50, width: 50));
                    } else {
                      return Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Image(
                        fit: BoxFit.cover,
                        image: CacheImage(snapshot.data),
                      ),),
                      );
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
                    'วันที่ ' +
                        DateFormat('dd/MM/yyyy').format(class_.beginDateTime),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Text(
                    'เวลา ' +
                        DateFormat('kk:mm').format(class_.beginDateTime) +
                        ' - ' +
                        DateFormat('kk:mm').format(class_.endDateTime) +
                        ' น.',
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
                FutureBuilder(
                    future: classModel.isReserved(class_.id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: LoadingWidget(height: 50, width: 50));
                      } else if (snapshot.data == null) {
                        return Center(
                            child: LoadingWidget(height: 50, width: 50));
                      } else {
                        return Center(
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.orange[900],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: (snapshot.data)
                                ? FlatButton(
                                    color: Colors.black,
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final result = await classModel
                                          .cancelClass(class_.id);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      if (result == 0) {
                                        print('cancel class success');
                                         _scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Cancel class success"),
                                                backgroundColor: Colors.green,
                                              ));
                                      } else if (result == -3) {
                                        print('cancel class failed');
                                        print('error code : $result');
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Cancle class failed out of time"),
                                          backgroundColor: Colors.red,
                                        ));
                                      } else {
                                        print('cancel class failed');
                                        print('error code : $result');
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Cancle class failed please try again"),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ))
                                : (class_.totalPerson >= class_.limitPerson)
                                    ? FlatButton(
                                        disabledColor: Colors.grey,
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Text(
                                          'Class is full',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ))
                                    : FlatButton(
                                        onPressed: () async {
                                          final resultDialog =
                                              await showClassDialog(context);
                                          if (resultDialog == 0) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            final result = await classModel
                                                .reserveClass(class_.id);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            if (result == 0) {
                                              print('reserve class success');
                                              print('reserve class failed');
                                              _scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Reserve class success"),
                                                backgroundColor: Colors.green,
                                              ));
                                            } else if (result == -2) {
                                              _scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Reserve class failed class is full"),
                                                backgroundColor: Colors.red,
                                              ));
                                            } else if (result == -3 ||
                                                result == -4) {
                                              _scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Reserve class failed out of time"),
                                                backgroundColor: Colors.red,
                                              ));
                                            } else if (result == -6) {
                                              _scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Reserve class failed you are in yellow card status"),
                                                backgroundColor: Colors.red,
                                              ));
                                            } else {
                                              print('reserve class failed');
                                              _scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Reserve class failed please try again"),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Text(
                                          'Reserve',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> showClassDialog(BuildContext context) async {
    Widget cancelButton = FlatButton(
      child: Text("CANCEL"),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(-1),
    );
    Widget continueButton = FlatButton(
      child: Text("CONFIRM"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop(0);
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
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
