import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

import 'pages.dart';

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
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return LoadingWidget(height: 50, width: 50);
          } else if (snapshot.data == null) {
            return Center(child: Text("Empty data!"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 240,
                  child: Card(
                    child: InkWell(
                      onTap: () => {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                            future: classModel
                                .getImageFromImageId(snapshot.data[index].id),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Container(
                                  height: 150.0,
                                  child: LoadingWidget(height: 50, width: 50),
                                );
                              } else if (snapshot.data == null) {
                                return Container(
                                  height: 150.0,
                                  child: LoadingWidget(height: 50, width: 50),
                                );
                              } else {
                                return Container(
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: snapshot.data,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          ListTile(
                            title: Text(snapshot.data[index].title,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(snapshot.data[index].beginDateTime.toString()),
                                      Spacer()
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('เวลา 16:00 - 17:00'),
                                      Spacer()
                                    ],
                                  ),
                                ]),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ClassPageDetail(),
                              ));
                            },
                          ),
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
