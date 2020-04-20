import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';


class AdminPackageEditingPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _pricePerDayController = TextEditingController();

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
  ]; //Sample

  final index = 0; //index from widget package page

  @override
  Widget build(BuildContext context) {

    _titleController.text = memberPackages[index].title;
    _detailController.text = memberPackages[index].detail;
    _priceController.text = memberPackages[index].price;
    _timeController.text = memberPackages[index].time;
    _pricePerDayController.text = memberPackages[index].pricePerDay;


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        title: Text('Edit Package'),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _detailController,
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Detail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _pricePerDayController,
                  decoration: InputDecoration(
                    labelText: 'Price per day',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 60,
                  child: FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.transparent)),
                      color: Colors.orange[900],
                      child: Text(
                        "CREATE",
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
      ),
    );
  }
}
