import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class AdminClassDetail extends StatelessWidget {
  const AdminClassDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminClassDetailChild();
  }
}

class AdminClassDetailChild extends StatefulWidget {
  @override
  _AdminClassDetailChildState createState() => _AdminClassDetailChildState();
}

class _AdminClassDetailChildState extends State<AdminClassDetailChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 240,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Container(
                    height: 240,
                    color: Colors.black54,
                    //child: Image(image: AssetImage()),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 30,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ชื่อคลาส',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'เวลา: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Kanit',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                //color: Colors.black54,
                child: Text(
                  'รายละเอียดเกี่ยวกับคลาสเรียน \nอาจมีความยาวแตกต่างกัน \nขึ้นอยู่กับ Admin ผู้สร้างคลาส \n'
                  'powurenvoiepqorbniopuhuoibxiyugvbwuyioiwgqiurhpoiujvjkjguibdscnsjdkjfcnksdiu',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Kanit',
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  color: Colors.orange[900],
                  child: Container(
                    height: 25,
                    width: 200,
                    child: Text(
                      'รายชื่อผู้เข้าร่วม',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Kanit'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
                FlatButton(
                  onPressed: () {},
                  color: Colors.blue,
                  child: Container(
                    height: 25,
                    width: 100,
                    child: Text(
                      'แก้ไข',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Kanit'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
                FlatButton(
                  onPressed: () {},
                  color: Colors.red,
                  child: Container(
                    height: 25,
                    child: Text(
                      'ลบ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Kanit'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
