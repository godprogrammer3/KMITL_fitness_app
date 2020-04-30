import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class NotificationPage extends StatelessWidget {
  final User user;

  const NotificationPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NotificationPageChild(user: user);
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

List<int> list = [4292149248, 4278241363, 4294929664, 4292149248];

Map<String,IconData> symbol = {
  'class': Icons.schedule,
  'post': Icons.assignment,
};

class NotificationPageChild extends StatelessWidget {
  final User user;
  const NotificationPageChild({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.orange[900],
      ),
      body: StreamBuilder(
          stream: NotificationModel(uid: user.uid).notifications,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else if (snapshot.data == null) {
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else {
              snapshot.data.sort();
              return ListView.separated(
                reverse: true,
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].title),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange[900],
                      child: Icon(symbol[snapshot.data[index].type]
                          ),
                      foregroundColor: Colors.white,
                    ),
                    subtitle: Text(snapshot.data[index].detail,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  );
                },
              );
            }
          }),
    );
  }
}
