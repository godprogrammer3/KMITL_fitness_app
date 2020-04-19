import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_reward_adding_page.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_reward_detail_page.dart';

class AdminRewardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminRewardPageChild();
  }
}

class AdminRewardPageChild extends State<AdminRewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.white,
          ),
          title: Text(
            "Reward",
            style: TextStyle(color: Colors.white, fontSize: 25),
            textAlign: TextAlign.left,
          ),
          backgroundColor: Colors.orange[900],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return AdminRewardAddingPage();
            }));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.orange[900],
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
                                      height: MediaQuery.of(context).size.height *
                                          0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/5percent.jpg'),
                                          fit: BoxFit.fitWidth,
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
                                      height: MediaQuery.of(context).size.height *
                                          0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/10percent.png'),
                                          fit: BoxFit.fitWidth,
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
                                      height: MediaQuery.of(context).size.height *
                                          0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/water.jpg'),
                                          fit: BoxFit.fitWidth,
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
                                      height: MediaQuery.of(context).size.height *
                                          0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/sponsor.png'),
                                          fit: BoxFit.fitWidth,
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
                        ]
                        ,
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
