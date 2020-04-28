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
      body: Container(
        child: StreamBuilder(
          stream: classModel.classes,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return LoadingWidget(height: 50, width: 50);
            } else if (snapshot.data == null) {
              return LoadingWidget(height: 50, width: 50);
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 10),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClassPageDetail(user:user,class_:snapshot.data[index]),
                        ));
                      },
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                future: classModel
                                    .getUrlFromImageId(snapshot.data[index].id),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(child: LoadingWidget(height: 50, width: 50));
                                  } else if (snapshot.data == null) {
                                    return Center(child: LoadingWidget(height: 50, width: 50));
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
                                title: Text(
                                  snapshot.data[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat('kk:mm').format(snapshot.data[index].beginDateTime)
                                  +
                                      ' - ' +
                                      DateFormat('kk:mm').format(snapshot.data[index].endDateTime)+' น.',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Text(
                                    'Created By: ' + snapshot.data[index].ownerFirstname),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 100,
                            right: 20,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: snapshot.data[index].totalPerson >= snapshot.data[index].limitPerson
                                      ? Colors.red
                                      : Colors.lightGreenAccent[700],
                                ),
                                child: Center(
                                  child: Text(
                                      snapshot.data[index].totalPerson.toString() +
                                          '/' +
                                          snapshot.data[index].limitPerson.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
