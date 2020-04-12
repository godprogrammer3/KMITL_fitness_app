import 'package:flutter/material.dart';

class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
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
                          onPressed: () {},
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