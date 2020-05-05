import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:quiver/async.dart';

class TreadmillShowDialog extends StatefulWidget {
  final User user;
  final String title;
  final DateTime startTime;
  final bool isCanSkip;
  final GlobalKey key;
  TreadmillShowDialog(
      {this.title, this.user, this.startTime, this.isCanSkip, this.key});

  @override
  _TreadmillShowDialogState createState() => _TreadmillShowDialogState(
      user: user, startTime: startTime, isCanSkip: isCanSkip, key: key);
}

class _TreadmillShowDialogState extends State<TreadmillShowDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  final DateTime startTime;
  int _start = 30;
  int _current = 30;
  final bool isCanSkip;
  CountdownTimer countDownTimer;
  var sub;
  final User user;
  TreadmillModel treadmillModel;
  final GlobalKey key;
  _TreadmillShowDialogState(
      {this.key, this.user, this.startTime, this.isCanSkip});
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
      if (sub != null) {
        sub.cancel();
      }
      if (countDownTimer != null) {
        countDownTimer.cancel();
      }
      if (context != null) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    treadmillModel = TreadmillModel(uid: user.uid);
    var totalSecond = 30-DateTime.now().difference(startTime).inSeconds;
    print("totalSecond : ");
    print(totalSecond);
    if(totalSecond < 0 ){
      totalSecond = 0;
    }
    _current = totalSecond;
    _start = totalSecond;
    countDownTimer = CountdownTimer(
      Duration(seconds: totalSecond),
      Duration(seconds: 1),
    );

    controller = AnimationController(
      duration: Duration(seconds: totalSecond),
      vsync: this,
    );
    controller.value = totalSecond.toDouble();
    controller.reverse(from: 1);
    startTimer();
  }

  @override
  void dispose() {
    if (sub != null) {
      sub.cancel();
    }
    if (countDownTimer != null) {
      countDownTimer.cancel();
    }
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
                top: 30,
                left: 70,
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
                top: 90,
                left: 130,
                child: Text(
                  _current.toString(),
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (isCanSkip == true)
                  ? <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await cancel();
                          if (sub != null) {
                            sub.cancel();
                          }
                          if (countDownTimer != null) {
                            countDownTimer.cancel();
                          }
                          Navigator.of(context, rootNavigator: true)
                              .popUntil((route) => route.isFirst);
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
                          if (sub != null) {
                            sub.cancel();
                          }
                          if (countDownTimer != null) {
                            countDownTimer.cancel();
                          }
                          Navigator.of(context, rootNavigator: true)
                              .popUntil((route) => route.isFirst);
                        },
                        child: Text(
                          'SKIP QUEUE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      )
                    ]
                  : <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await cancel();
                          if (sub != null) {
                            sub.cancel();
                          }
                          if (countDownTimer != null) {
                            countDownTimer.cancel();
                          }
                          if (context != null && this.mounted) {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          }
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
                    ])
        ],
      ),
    );
  }
}
