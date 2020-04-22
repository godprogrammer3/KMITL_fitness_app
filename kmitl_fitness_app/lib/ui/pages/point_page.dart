import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class PointPage extends StatefulWidget {
  final User user;

  const PointPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PointPageChild(user: user);
  }
}

class PointPageChild extends State<PointPage> {
  final User user;

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.transparent)),
            child: Container(
              height: 450,
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/5percent.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "ส่วนลด 5%",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                  Text("ใช้ 50 point"),
                  SizedBox(height: 20),
                  Text(
                      'ส่วนลดใช้กับ package membership รายเดือนจาก 500 บาท เหลือ 475 บาท'),
                  Text('วิธีใช้',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text('กดแลกรับแล้วเข้าไปหน้าmembership ระบบจะลดราคา'),
                  SizedBox(height: 10,),
                  Text('เงื่อนไข',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text('- 1 สิทธิ์ / 1 ท่าน / 1 เดือน'),
                  Text('- จำกัด 1,000 สิทธิ์'),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.transparent)),
                      color: Colors.orange[900],
                      child: Text(
                        "แลกรับ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          );
        });
  }

  PointPageChild({this.user});
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 0,
                child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.stars,
                          color: Colors.orange[900],
                        ),
                        Text(
                          "300",
                          style: TextStyle(fontSize: 23),
                        )
                      ],
                    )),
              ),
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
                                  createAlertDialog(context);
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
                                  /*
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return AdminRewardDetailPage();
                                  }));*/
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
                                  /*
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return AdminRewardDetailPage();
                                  }));*/
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
                                  /*
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return AdminRewardDetailPage();
                                  }));*/
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
