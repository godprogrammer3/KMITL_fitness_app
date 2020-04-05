import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationPageChild();
  }
}

var messages = const [
  {'subject': 'LOCKER', 'body': 'คุณใช้ล็อคเกอร์นานเกินกำหนดแล้วนะ'},
  {'subject': 'Treadmill is READY!', 'body': 'Treadmill ของคุณพร้อมแล้ว!!!'},
  {'subject': 'CLASS', 'body': 'Class ของคุณจะเริ่มในอีก 30 นาที'},
  {
    'subject': 'CLASS',
    'body': 'คุณไม่ได้เช็คชื่อเข้าคลาสที่ลงไว้ จะติดสถานะใบเหลือง'
  }
];

class NotificationPageChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                print("back");
              }),
          title: (Text(
            "Notification",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
          backgroundColor: Colors.orange[900],
        ),
        
        body: ListView.separated(
          itemCount: messages.length,
          //itemCount: 21,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            var message = messages[index];

            return ListTile(
              //trailing: Text('Z'),
              title: Text(message['subject']),
              //title: Text('Title $index'),
              isThreeLine: true,
              leading: CircleAvatar(

  backgroundColor: Colors.red,

                child: Icon(Icons.vpn_key)
                // child: Text(
                // 'UI',
                // style: TextStyle(color: Colors.white),
                //),
              ),
              //subtitle: Text('Greyhound divisively hello coldly'),
              subtitle: Text(message['body'],
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            );
          },
        ));
  }
}
