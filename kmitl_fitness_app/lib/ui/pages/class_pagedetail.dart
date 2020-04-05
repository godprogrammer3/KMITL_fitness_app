import 'package:flutter/material.dart';
class ClassPageDetail extends StatelessWidget {
  const ClassPageDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassPageDetailChild();
  }
}

class ClassPageDetailChild extends StatefulWidget {
  @override
  _ClassPageDetailStateChild createState() => _ClassPageDetailStateChild();
}

class _ClassPageDetailStateChild extends State<ClassPageDetailChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/images/YogaEx.jpg',fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
            child: Text(
              'Yoga Class',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
            child: Text(
              'วันที่ 26/03/2020',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,10.0,20.0,0.0),
            child: Text(
              'เวลา 16:00 - 17:00',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
            child: Text(
              'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Spacer(),
          Center(
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange[900],
                borderRadius: BorderRadius.all(Radius.circular(100))),
                child: FlatButton(
                  onPressed: () {showClassDialog(context);},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Text(
                    'Reserve',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
  showClassDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("CANCEL"),
      onPressed:  () => Navigator.of(context).pop(true),
    );
    Widget continueButton = FlatButton(
      child: Text("CONFIRM"),
      onPressed:  () {},
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("Confirm Reservation"),
      content: Text("""ยืนยันการจองคลาสนี้ หรือไม่?\nหากท่านไม่มาเข้าคลาสตามที่กำหนดท่านจะถูกติดสถานะใบเหลือง\n\n*สามารถยกเลิกการจองก่อนเริ่มคลาสอย่างน้อย 30 นาที"""),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
