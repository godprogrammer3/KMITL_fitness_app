import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class TreadmillPage extends StatelessWidget {
  const TreadmillPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TreadmillPageChild();
  }
}

class TreadmillPageChild extends StatefulWidget {
  @override
  _TreadmillPageStateChild createState() => _TreadmillPageStateChild();
}

class _TreadmillPageStateChild extends State<TreadmillPageChild> {
  List<String> queue = ['First', 'Second', 'Third', 'Fourth', 'Fifth'];
  final color = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<bool> treadmillFree = [false, false, true];
  bool called = false;

  void queueUp() {
    setState(() {
      queue.add('You');
      color.add(Colors.lightGreenAccent[700]);
      _inQueue = !_inQueue;
    });
  }

  bool _inQueue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Treadmill'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.timelapse),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => CustomDialog(
                  title: 'Treadmill is ready!',
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Card(
              margin: EdgeInsets.fromLTRB(0, 35, 0, 35),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'No. 1',
                          style: TextStyle(
                            fontSize: 20,
                            color: treadmillFree[0]
                                ? Colors.lightGreenAccent[700]
                                : Colors.black26,
                          ),
                        ),
                        Icon(
                          Icons.directions_run,
                          color: treadmillFree[0]
                              ? Colors.lightGreenAccent[700]
                              : Colors.black26,
                          size: 75,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'No. 2',
                          style: TextStyle(
                            fontSize: 20,
                            color: treadmillFree[1]
                                ? Colors.lightGreenAccent[700]
                                : Colors.black26,
                          ),
                        ),
                        Icon(
                          Icons.directions_run,
                          color: treadmillFree[1]
                              ? Colors.lightGreenAccent[700]
                              : Colors.black26,
                          size: 75,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'No. 3',
                          style: TextStyle(
                            fontSize: 20,
                            color: treadmillFree[2]
                                ? Colors.lightGreenAccent[700]
                                : Colors.black26,
                          ),
                        ),
                        Icon(
                          Icons.directions_run,
                          color: treadmillFree[2]
                              ? Colors.lightGreenAccent[700]
                              : Colors.black26,
                          size: 75,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            'Queue',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
          ),
          Container(
            //Need ListView, ListTile, and Pull data from Firebase
            margin: EdgeInsets.only(top: 15, bottom: 5),
            width: 330,
            height: 230,
            //color: Colors.black26,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: queue.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: color[index],
                          elevation: 1,
                          child: ListTile(
                            title: Text(queue[index]),
                            leading: Icon(Icons.face),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ButtonTheme(
            minWidth: 330,
            height: 50,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _inQueue ? 'You are in queue' : 'Queue Up',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: _inQueue ? null : queueUp, //Firebase
              color: Colors.orange[900],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  final String title;

  CustomDialog({this.title});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  int _start = 30;
  int _current = 30;

  CountdownTimer countDownTimer = CountdownTimer(
    Duration(seconds: 30),
    Duration(seconds: 1),
  );

  void startTimer() {
    var sub = countDownTimer.listen(null);

    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
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
    return Stack(
      children: <Widget>[
        Container(
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
                style: TextStyle(fontSize: 30),
              ),
              Text(
                _current.toString(),
                style: TextStyle(fontSize: 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      countDownTimer.cancel();
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      countDownTimer.cancel();
                    },
                    child: Text(
                      'SKIP QUEUE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
