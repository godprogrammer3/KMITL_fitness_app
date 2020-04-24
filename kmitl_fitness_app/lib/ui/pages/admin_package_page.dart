import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminPackagePage extends StatefulWidget {
  @override
  _AdminPackagePageState createState() => _AdminPackagePageState();
}

class _AdminPackagePageState extends State<AdminPackagePage> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return AdminPackageAddingPage();
          }));
        },
        icon: Icon(Icons.add),
        label: Text('Create'),
        elevation: 10,
      ),
      body: ListView.builder(
        itemCount: memberPackages.length,
        itemBuilder: (contex, index) {
          return SizedBox(
            //height: 220,
            child: Card(
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return AdminPackageEditingPage(memberPackages, index);
                  }));
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
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
      ),
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
