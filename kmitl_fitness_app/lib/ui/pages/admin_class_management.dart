import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AdminClassManagement extends StatelessWidget {
  final User user;
  const AdminClassManagement({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminClassManagementChild(user: user);
  }
}

class AdminClassManagementChild extends StatefulWidget {
  final User user;
  const AdminClassManagementChild({Key key, this.user}) : super(key: key);

  @override
  _AdminClassManagementChildState createState() =>
      _AdminClassManagementChildState(user: user);
}

class _AdminClassManagementChildState extends State<AdminClassManagementChild> {
  final User user;
  ClassModel classModel;
  _AdminClassManagementChildState({this.user});
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
        title: Text('Class Management'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AdminNotificationPage(user: user);
              }));
            },
            color: Colors.white,
          )
        ],
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
              if(snapshot.data.length == 0){
                return Center(child:Text('Empty',style: TextStyle(fontSize: 30),));
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
                          builder: (context) => AdminClassDetail(
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
                                    .getUrlFromImageId(reveseList[index].id),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasError) {
                                    return LoadingWidget(height: 50, width: 50);
                                  } else if (snapshot.data == null) {
                                    return LoadingWidget(height: 50, width: 50);
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
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat('kk:mm').format(
                                          reveseList[index].beginDateTime) +
                                      ' - ' +
                                      DateFormat('kk:mm').format(
                                          reveseList[index].endDateTime) +
                                      ' น.',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Text('Created By: ' +
                                    reveseList[index].ownerFirstname),
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
                                      reveseList[index].totalPerson
                                              .toString() +
                                          '/' +
                                          reveseList[index].limitPerson
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminClassEdit(user: user),
          ));
        },
        icon: Icon(Icons.add),
        label: Text('Create'),
        elevation: 10,
      ),
    );
  }
}
