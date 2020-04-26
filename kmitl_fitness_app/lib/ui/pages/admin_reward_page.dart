import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_reward_adding_page.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_reward_detail_page.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class AdminRewardPage extends StatefulWidget {
  final User user;

  const AdminRewardPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AdminRewardPageChild(user:user);
  }
}

class AdminRewardPageChild extends State<AdminRewardPage> {
  final User user;

  AdminRewardPageChild({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AdminRewardAddingPage(),
            ));
          },
          icon: Icon(Icons.add),
          label: Text('Create'),
          elevation: 10,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      GridView.count(
                        physics: ScrollPhysics(),
                        primary: true,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Container(
                            child: Card(
                              elevation: 5.0,
                              margin: EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return AdminRewardDetailPage();
                                  }));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/5percent.jpg',),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('ส่วนลด 5 %',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text("ใช้  50 point"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              elevation: 5.0,
                              margin: EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return AdminRewardDetailPage();
                                  }));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/10percent.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('ส่วนลด 10 %',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text("ใช้  100 point"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              elevation: 5.0,
                              margin: EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return AdminRewardDetailPage();
                                  }));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/water.jpg'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('น้ำดื่ม',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text("ใช้  199 point"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              elevation: 5.0,
                              margin: EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return AdminRewardDetailPage();
                                  }));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/sponsor.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('น้ำดื่มเกลือแร่',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text("ใช้  299 point"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}
