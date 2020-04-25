import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_class_edit.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_class_participants.dart';

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
  String className = 'Class Name';
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
                    icon: Icon(Icons.arrow_back_ios),
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
                    'Class Name',
                    style: TextStyle(
                      fontSize: 40,
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
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AdminClassParticipants(),
                    ));
                  },
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
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AdminClassEdit(),
                    ));
                  },
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
                RaisedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 20,
                        title: Text(
                          'ลบคลาส?',
                          style: TextStyle(fontSize: 30, fontFamily: 'Kanit'),
                        ),
                        content: Text(
                          'คุณแน่ใจหรือไม่ที่จะทำการลบคลาส ' + className,
                          style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              'ไม่',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  color: Colors.black54),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text(
                              'ใช่',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  color: Colors.orange[900]),
                            ),
                            onPressed: () {
                              print('Deleted');
                            },
                          ),
                        ],
                      ),
                    );
                  },
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
