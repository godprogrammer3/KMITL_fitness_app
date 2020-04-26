import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:intl/intl.dart';

class ClassPage extends StatelessWidget {
  final User user;
  ClassPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassPageChild(user: user);
  }
}

class ClassPageChild extends StatefulWidget {
  final User user;

  const ClassPageChild({Key key, this.user}) : super(key: key);
  @override
  _ClassPageStateChild createState() => _ClassPageStateChild(user: user);
}

class _ClassPageStateChild extends State<ClassPageChild> {
  final User user;
  ClassModel classModel;
  _ClassPageStateChild({this.user});

  @override
  void initState() {
    super.initState();
    classModel = ClassModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Class',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NotificationPage();
              }));
            },
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.orange[900],
      ),
      body: StreamBuilder(
          stream: classModel.classes,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasError) {
      return LoadingWidget(height: 50, width: 50);
            } else if (snapshot.data == null) {
      return Center(child: Text("Empty"));
            } else {
      if (snapshot.data.length == 0) {
        return Center(child: Text("Empty"));
      }
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 240,
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ClassPageDetail(
                        user: user, class_: snapshot.data[index]),
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FutureBuilder(
                      future: classModel
                          .getUrlFromImageId(snapshot.data[index].id),
                      builder:
                          (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return LoadingWidget(height: 50, width: 50);
                        } else if (snapshot.data == null) {
                          return LoadingWidget(height: 50, width: 50);
                        } else {
                          return Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    ListTile(
                        title: Text(snapshot.data[index].title,
                            style:
                                TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('วันที่ ' +
                                      DateFormat('dd/MM/yyyy').format(
                                          snapshot.data[index]
                                              .beginDateTime)),
                                  Spacer()
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('เวลา ' +
                                      DateFormat('hh:mm').format(snapshot
                                          .data[index].beginDateTime) +
                                      ' - ' +
                                      snapshot
                                          .data[index].endDateTime.hour
                                          .toString() +
                                      ':' +
                                      snapshot
                                          .data[index].endDateTime.minute
                                          .toString()),
                                ],
                              ),
                            ]),
                        onTap: null),
                  ],
                ),
              ),
            ),
          );
        },
      );
            }
          },
        ),
    );
  }
}
