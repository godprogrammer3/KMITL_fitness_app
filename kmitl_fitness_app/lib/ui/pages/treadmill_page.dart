import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:quiver/async.dart';
import 'package:kmitl_fitness_app/main.dart';

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
  _TreadmillPageStateChild({this.user});
  Function buttonFunction;
  String buttonText = 'Queue up';
  Color buttonColor = Colors.orange[900];
  void enQueue() async {
    final result = await treadmillModel.enQueue();
    if (result != 0) {
      print('you can not enqueue');
    } else {
      print('enqueu success');
    }
  }

  void cancel() async {
    final result = await treadmillModel.cancel();
    if (result != 0) {
      print('you can not cancel');
    } else {
      print('cancel success');
    }
  }

  void done() async {
    final result = await treadmillModel.done();
    if (result != 0) {
      print('you can not done');
    } else {
      setState(() {
        buttonText = 'Queue up';
        buttonFunction = enQueue;
        buttonColor = Colors.orange[900];
      });
      print('done success');
    }
  }

  final User user;
  TreadmillModel treadmillModel;
  @override
  void initState() {
    super.initState();
    treadmillModel = TreadmillModel(uid: user.uid);
    buttonFunction = enQueue;
    eventbus.on<ShowTreadmillPopup>().listen((event) async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CustomDialog(
            title: 'Treadmill is ready!',
            user: user,
            totalSecond: 30 - event.totalSecond.abs(),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Treadmill'),
      ),
      body: Container(
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
                              if (i.user == user.uid &&
                                  i.isAvailable == false) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) => setState(() {
                                          buttonText = 'done';
                                          buttonFunction = done;
                                          buttonColor = Colors.blue;
                                        }));
                              }
                              widgets.add(
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      'No. ' + (int.parse(i.id) + 1).toString(),
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
                              return Center(
                                  child: Text("Queue is empty.",
                                      style: TextStyle(fontSize: 25)));
                            } else {
                              if (asyncSnapshot.data.length == 0) {
                                return Center(
                                    child: Text("Queue is empty.",
                                        style: TextStyle(fontSize: 25)));
                              }
                              return ListView.builder(
                                itemCount: asyncSnapshot.data.length,
                                itemBuilder: (context, index) {
                                  if (asyncSnapshot.data[index]['user'] ==
                                      user.uid) {
                                    if (buttonText != 'done') {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => setState(() {
                                                    buttonText = 'Cancel queue';
                                                    buttonFunction = cancel;
                                                    buttonColor = Colors.black;
                                                  }));
                                    }
                                  }
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: asyncSnapshot.data[index]['user'] ==
                                            user.uid
                                        ? Colors.lightGreenAccent[700]
                                        : Colors.white,
                                    elevation: 1,
                                    child: ListTile(
                                      title: Text(asyncSnapshot.data[index]
                                          ['firstName']),
                                      leading: Icon(Icons.face),
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                    ),
                    ButtonTheme(
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
                    ),
                    onPressed: _inQueue ? null : queueUp, //Firebase
                    color: Colors.orange[900],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  final User user;
  final String title;
  final int totalSecond;
  CustomDialog({this.title, this.user, this.totalSecond});

  @override
  _CustomDialogState createState() =>
      _CustomDialogState(user: user, totalSecond: totalSecond);
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  final int totalSecond;
  int _start = 30;
  int _current = 30;

  CountdownTimer countDownTimer;
  var sub;
  final User user;
  TreadmillModel treadmillModel;
  _CustomDialogState({this.user, this.totalSecond});
  void startTimer() {
    sub = countDownTimer.listen(null);

    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });
    sub.onDone(() async {
      await cancel();
      print("Done");
      sub.cancel();
      if (this.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    treadmillModel = TreadmillModel(uid: user.uid);
    if (totalSecond != null) {
      _current = totalSecond;
      _start = totalSecond;
      countDownTimer = CountdownTimer(
        Duration(seconds: totalSecond),
        Duration(seconds: 1),
      );
    } else {
      countDownTimer = CountdownTimer(
        Duration(seconds: 30),
        Duration(seconds: 1),
      );
    }
    controller = AnimationController(
      duration: Duration(seconds: 30),
      vsync: this,
    );
    controller.value = totalSecond != null ? totalSecond.toDouble() : 30.0;
    controller.reverse(from: 1);
    startTimer();
  }

  @override
  void dispose() {
    sub.cancel();
    controller.dispose();
    super.dispose();
  }

  Future<void> skip() async {
    final result = await treadmillModel.skip();
    if (result != 0) {
      print('you can not skip');
    }
  }

  Future<void> cancel() async {
    await treadmillModel.cancel();
    await treadmillModel.done();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontSize: 25),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(children: <Widget>[
              Positioned(
                top: 50,
                left: 50,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    value: controller.value,
                    strokeWidth: 20,
                    backgroundColor: Colors.black26,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                ),
              ),
              Positioned(
                top: 107,
                left: 107,
                child: Text(
                  _current.toString(),
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  await cancel();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  countDownTimer.cancel();
                },
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  await skip();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  countDownTimer.cancel();
                },
                child: Text(
                  'SKIP QUEUE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
