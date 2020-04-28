import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AdminPackagePage extends StatefulWidget {
  final User user;
  const AdminPackagePage({Key key, this.user}) : super(key: key);
  @override
  _AdminPackagePageState createState() => _AdminPackagePageState(user: user);
}

class _AdminPackagePageState extends State<AdminPackagePage> {
  final User user;
  PackageModel packageModel;
  _AdminPackagePageState({this.user});
  @override
  void initState() {
    super.initState();
    packageModel = PackageModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return AdminPackageAddingPage(user: user);
          }));
        },
        icon: Icon(Icons.add),
        label: Text('Create'),
        elevation: 10,
      ),
      body: StreamBuilder(
          stream: packageModel.packages,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                    //height: 220,
                    child: Card(
                      margin: EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return AdminPackageEditingPage(
                                user:user,package:snapshot.data[index]);
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[index].title,
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontSize: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          snapshot.data[index].detail.replaceAll('\\n','\n'),
                                          style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ]),
                                  Column(
                                    children: <Widget>[
                                      FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                          '฿'+snapshot.data[index].price.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        '/'+snapshot.data[index].period,
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontSize: 24,
                                            height: 0.75),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        '฿'+snapshot.data[index].pricePerDay.toString()+'ต่อวัน',
                                        style: TextStyle(
                                            fontFamily: 'Kanit', fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              Text('EDIT',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'Kanit',
                                      color: Colors.orange[900])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
