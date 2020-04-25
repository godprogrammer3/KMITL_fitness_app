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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return AdminPackageAddingPage(user:user);
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[900],
      ),
      body: StreamBuilder(
          stream: packageModel.packages,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
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
                    height: 280,
                    child: Card(
                      margin: EdgeInsets.all(20.0),
                      child: Container(
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        snapshot.data[index].detail
                                            .replaceAll('\\n', '\n'),
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
                                        '฿' +
                                            snapshot.data[index].price
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '/' + snapshot.data[index].period,
                                      style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 20,
                                          height: 0.75),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      '฿' +
                                          snapshot.data[index].pricePerDay
                                              .toString() +
                                          ' ต่อวัน',
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 200,
                              height: 45,
                              child: FlatButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder:
                                                (BuildContext context) {
                                                  return AdminPackageEditingPage(user:user, package:snapshot.data[index]);
                                                }));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                  color: Colors.orange[800],
                                  child: Text(
                                    "EDIT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
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

class AdminPackage {
  String title;
  String detail;
  String price;
  String time;
  String pricePerDay;
  AdminPackage(
      {this.title, this.detail, this.price, this.time, this.pricePerDay});
}
