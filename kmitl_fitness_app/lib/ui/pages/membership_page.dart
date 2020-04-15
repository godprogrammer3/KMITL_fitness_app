import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:url_launcher/url_launcher.dart';

class MembershipPage extends StatefulWidget {
  final User user;

  const MembershipPage({Key key, this.user}) : super(key: key);
  @override
  _MembershipPageState createState() => _MembershipPageState(user: user);
}

class _MembershipPageState extends State<MembershipPage> {
  final List<MemberPackage> memberPackages = [
    MemberPackage(
        title: "โปรรายวันเบาๆ",
        detail: "ใช้งานฟิตเนสตลอดวัน \nในวันที่สมัครใช้งาน",
        price: "฿30",
        time: "/วัน",
        pricePerDay: ""),
    MemberPackage(
        title: "โปรเดือนฟิต",
        detail: "ใช้งานฟิตเนสตลอด 30 วัน \nนับตั้งแต่วันที่สมัครใช้งาน",
        price: "฿500",
        time: "/เดือน",
        pricePerDay: "฿16.67 ต่อวัน"),
    MemberPackage(
        title: "โปรเปิดเทอม",
        detail: "ใช้งานฟิตเนสตลอด 4 เดือน \nนับตั้งแต่วันที่สมัครใช้งาน",
        price: "฿1,700",
        time: "/4 เดือน",
        pricePerDay: "฿14.16 ต่อวัน")
  ];
  final User user;
  _MembershipPageState({this.user});
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('can not launch url :' + url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Membership"),
      ),
      body: ListView.builder(
        itemCount: memberPackages.length,
        itemBuilder: (contex, index) {
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                memberPackages[index].title,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                memberPackages[index].detail,
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
                                memberPackages[index].price,
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              memberPackages[index].time,
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 24,
                                  height: 0.75),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              memberPackages[index].pricePerDay,
                              style:
                                  TextStyle(fontFamily: 'Kanit', fontSize: 12),
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
                            if (index == 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return PaymentPage(
                                    url:
                                        'https://kmitlfitnessapp.web.app/payment?amount=3000&userId=' +
                                            user.uid+'&packageId='+index.toString());
                              }));
                            } else if (index == 1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return PaymentPage(
                                    url:
                                        'https://kmitlfitnessapp.web.app/payment?amount=50000&userId=' +
                                            user.uid+'&packageId='+index.toString());
                              }));
                            } else if (index == 2) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return PaymentPage(
                                    url:
                                        'https://kmitlfitnessapp.web.app/payment?amount=170000&userId=' +
                                            user.uid+'&packageId='+index.toString());
                              }));
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(color: Colors.transparent)),
                          color: Colors.orange[800],
                          child: Text(
                            "GET",
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
      ),
    );
  }
}

class MemberPackage {
  String title;
  String detail;
  String price;
  String time;
  String pricePerDay;
  MemberPackage(
      {this.title, this.detail, this.price, this.time, this.pricePerDay});
}
