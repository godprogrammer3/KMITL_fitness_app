import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';

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
  List<String> queue = <String>['First', 'Second', 'Third', 'Fourth', 'Fifth'];
  final User user;
  TreadmillModel treadmillModel;

  _TreadmillPageStateChild({this.user});
  void queueUp() async {
    if (this.mounted) {
      //final result = await treadmillModel.enQueue();
      //final result = await treadmillModel.skip();
      //final result = await treadmillModel.cancel();
      //final result = await treadmillModel.enQueue();
      final result = await treadmillModel.done();
      if(result != 0){
        print('you cant not cancel');
      }
      setState(() {
        queue.add('You');
        _inQueue = !_inQueue;
      });
    }
  }

  bool _inQueue = false;
  @override
  void initState() {
    super.initState();
    treadmillModel = TreadmillModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Treadmill'),
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
                            color: Colors.black26,
                          ),
                        ),
                        Icon(
                          Icons.directions_run,
                          color: Colors.black12,
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
                            color: Colors.black26,
                          ),
                        ),
                        Icon(
                          Icons.directions_run,
                          color: Colors.black12,
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
                            color: Colors.lightGreenAccent[700],
                          ),
                        ),
                        Icon(
                          Icons.directions_run,
                          color: Colors.lightGreenAccent[700],
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
