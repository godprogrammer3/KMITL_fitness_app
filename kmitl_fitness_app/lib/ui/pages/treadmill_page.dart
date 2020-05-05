import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TreadmillPage extends StatelessWidget {
  final User user;
  const TreadmillPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TreadmillPageChild(user: user);
  }
}

class TreadmillPageChild extends StatefulWidget {
  final User user;

  const TreadmillPageChild({Key key, this.user}) : super(key: key);
  @override
  _TreadmillPageStateChild createState() =>
      _TreadmillPageStateChild(user: user);
}

class _TreadmillPageStateChild extends State<TreadmillPageChild> {
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _TreadmillPageStateChild({this.user});
  Function buttonFunction;
  String buttonText = 'Queue up';
  Color buttonColor = Colors.orange[900];
  void enQueue() async {
    setState(() {
      _isLoading = true;
    });
    final result = await treadmillModel.enQueue();
    setState(() {
      _isLoading = false;
    });
    if (result == 0) {
      print('enqueue success');
    } else {
      print('you cannot enqueue');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Enqueue failed please try again"),
        backgroundColor: Colors.red,
      ));
    }
  }

  void cancel() async {
    setState(() {
      _isLoading = true;
    });
    final result = await treadmillModel.cancel();
    setState(() {
      _isLoading = false;
    });
    if (result == 0) {
      print('cancel success');
    } else {
      print('you cannot cancel');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Cancel queue failed please try again"),
        backgroundColor: Colors.red,
      ));
    }
  }

  void done() async {
    setState(() {
      _isLoading = true;
    });
    final result = await treadmillModel.done();
    setState(() {
      _isLoading = false;
    });
    if (result == 0) {
      print('done success');
    } else {
      print('you cannot done');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Done queue failed please try again"),
        backgroundColor: Colors.red,
      ));
    }
  }

  final User user;
  TreadmillModel treadmillModel;
  bool _isCanSkip;
  GlobalKey _popupKey;
  StreamSubscription<List<TreadmillStatus>> treadmillStatusSubscription;
  StreamSubscription<List<TreadmillQueue>> treadmillQueueSubscription;
  StreamController<int> userStatusStreamController = StreamController();
  @override
  void initState() {
    super.initState();
    treadmillModel = TreadmillModel(uid: user.uid);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    treadmillStatusSubscription = treadmillModel.status.listen((value) async {
      for (var i in value) {
        if (i.user == user.uid &&
            i.isAvailable == true &&
            i.startTime != null) {
          _popupKey = GlobalKey(debugLabel: 'Treadmill popup key');
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => TreadmillShowDialog(
              key: this._popupKey,
              title: 'Treadmill is ready!',
              user: this.user,
              startTime: i.startTime,
              isCanSkip: _isCanSkip,
            ),
          );
        } else if (i.user == user.uid && i.isAvailable == false) {
          print('close by here');
          if (_popupKey != null && _popupKey.currentContext != null) {
            Navigator.of(_popupKey.currentContext, rootNavigator: true)
                .popUntil((route) => route.isFirst);
          }
        }
      }
      final status = await treadmillModel.checkUserStatus();
      if (!userStatusStreamController.isClosed) {
        userStatusStreamController.add(status);
      }
    });
    treadmillQueueSubscription = treadmillModel.queues.listen((value) async {
      if (value.length > 1) {
        _isCanSkip = true;
      } else {
        _isCanSkip = false;
      }
      final status = await treadmillModel.checkUserStatus();
      if (!userStatusStreamController.isClosed) {
        userStatusStreamController.add(status);
      }
    });
  }

  @override
  void dispose() {
    treadmillStatusSubscription.cancel();
    treadmillQueueSubscription.cancel();
    userStatusStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Treadmill'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return NotificationPage(user: user);
                }));
              },
              color: Colors.white,
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: LoadingOverlay(
            isLoading: _isLoading,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(children: <Widget>[
                Flexible(
                  flex: 0,
                  child: Card(
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Container(
                      width: 330,
                      height: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          StreamBuilder(
                              stream: TreadmillModel(uid: user.uid).status,
                              builder: (context, asyncSnapshot) {
                                if (asyncSnapshot.hasError) {
                                  return LoadingWidget(height: 50, width: 50);
                                } else if (asyncSnapshot.data == null) {
                                  return new Text("Empty data!");
                                } else {
                                  List<Widget> widgets = new List<Widget>();
                                  for (var i in asyncSnapshot.data) {
                                    widgets.add(
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'No. ' +
                                                (int.parse(i.id) + 1)
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: i.user == ''
                                                  ? Colors.lightGreenAccent[700]
                                                  : Colors.black26,
                                            ),
                                          ),
                                          Icon(
                                            Icons.directions_run,
                                            color: i.user == ''
                                                ? Colors.lightGreenAccent[700]
                                                : Colors.black26,
                                            size: 75,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: widgets);
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Text(
                    'Queue',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: StreamBuilder(
                                stream: TreadmillModel(uid: user.uid).queues,
                                builder: (context, asyncSnapshot) {
                                  if (asyncSnapshot.hasError) {
                                    return LoadingWidget(height: 50, width: 50);
                                  } else if (asyncSnapshot.data == null) {
                                    _isCanSkip = false;
                                    return Center(
                                        child: Text("Queue is empty",
                                            style: TextStyle(fontSize: 25)));
                                  } else {
                                    if (asyncSnapshot.data.length == 0) {
                                      _isCanSkip = false;
                                      return Center(
                                          child: Text("Queue is empty",
                                              style: TextStyle(fontSize: 25)));
                                    }
                                    asyncSnapshot.data.sort();
                                    return ListView.builder(
                                      itemCount: asyncSnapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          color:
                                              asyncSnapshot.data[index].user ==
                                                      user.uid
                                                  ? Colors.lightGreenAccent[700]
                                                  : Colors.white,
                                          elevation: 1,
                                          child: ListTile(
                                            title: Text((index + 1).toString() +
                                                ' ' +
                                                asyncSnapshot
                                                    .data[index].firstName),
                                            leading: Icon(Icons.face),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }),
                          ),
                          StreamBuilder(
                              stream: userStatusStreamController.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot asyncSnapshot) {
                                if (asyncSnapshot.hasError) {
                                  return LoadingWidget(height: 50, width: 50);
                                } else if (asyncSnapshot.data == null) {
                                  return LoadingWidget(height: 50, width: 50);
                                } else {
                                  if (asyncSnapshot.data == 0) {
                                    buttonText = 'Done';
                                    buttonColor = Colors.blue;
                                    buttonFunction = done;
                                  } else if (asyncSnapshot.data == 1) {
                                    buttonText = 'Cancel queue';
                                    buttonColor = Colors.black;
                                    buttonFunction = cancel;
                                  } else {
                                    buttonText = 'Queue up';
                                    buttonColor = Colors.orange[900];
                                    buttonFunction = enQueue;
                                  }
                                  return ButtonTheme(
                                    minWidth: 330,
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        buttonText,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: buttonFunction, //Firebase
                                      color: buttonColor,
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
