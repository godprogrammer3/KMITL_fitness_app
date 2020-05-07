import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:cache_image/cache_image.dart';

class ClassPage extends StatelessWidget {
  final User user;
  ClassPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserModel(uid: user.uid).getUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NotificationPage(user: user);
                        }));
                      },
                      color: Colors.white,
                    )
                  ],
                  backgroundColor: Colors.orange[900],
                ),
                body: Center(
                    child:
                        Center(child: LoadingWidget(height: 50, width: 50))));
          } else if (snapshot.data == null) {
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NotificationPage(user: user);
                        }));
                      },
                      color: Colors.white,
                    )
                  ],
                  backgroundColor: Colors.orange[900],
                ),
                body: Center(
                    child:
                        Center(child: LoadingWidget(height: 50, width: 50))));
          } else {
            final expireDate = DateTime.parse(DateFormat('yyyy-MM-dd')
                .format(snapshot.data.membershipExpireDate));
            final currentDate =
                DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
            final bool isNotExpired = currentDate.isBefore(expireDate);
            if (isNotExpired) {
              return ClassPageChild(user: user);
            } else {
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NotificationPage(user: user);
                        }));
                      },
                      color: Colors.white,
                    )
                  ],
                  backgroundColor: Colors.orange[900],
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Exclusive feature!\n',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Please purchase a membership',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        });
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
                return NotificationPage(user: user);
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
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else if (snapshot.data == null) {
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else {
              if (snapshot.data.length == 0) {
                return Center(
                    child: Text(
                  'Empty',
                  style: TextStyle(fontSize: 30),
                ));
              }
              snapshot.data.sort();
              List<Class> reveseList = List.from(snapshot.data.reversed);
              return ListView.builder(
                itemCount: reveseList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 10),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClassPageDetail(
                              user: user, class_: reveseList[index]),
                        ));
                      },
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                future: classModel
                                    .getUrlFromImageId(reveseList[index].imageId),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                        child: LoadingWidget(
                                            height: 50, width: 50));
                                  } else if (snapshot.data == null) {
                                    return Center(
                                        child: LoadingWidget(
                                            height: 50, width: 50));
                                  } else {
                                    return Container(
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: CacheImage(snapshot.data),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              ListTile(
                                title: Text(
                                  reveseList[index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      fontFamily: 'Kanit'),
                                ),
                                subtitle: Text(
                                  DateFormat('kk:mm').format(
                                          reveseList[index].beginDateTime) +
                                      ' - ' +
                                      DateFormat('kk:mm').format(
                                          reveseList[index].endDateTime) +
                                      ' น.',
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Kanit'),
                                ),
                                trailing: Text(
                                  'Created By: ' +
                                      reveseList[index].ownerFirstname,
                                ),
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
                                  color: reveseList[index].totalPerson >=
                                          reveseList[index].limitPerson
                                      ? Colors.red
                                      : Colors.lightGreenAccent[700],
                                ),
                                child: Center(
                                  child: Text(
                                      reveseList[index].totalPerson.toString() +
                                          '/' +
                                          reveseList[index]
                                              .limitPerson
                                              .toString(),
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
