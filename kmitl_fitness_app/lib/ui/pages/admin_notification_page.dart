import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AdminNotificationPage extends StatelessWidget {
  final User user;

  const AdminNotificationPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdminNotificationPageChild(user: user);
  }
}

class AdminNotificationPageChild extends StatelessWidget {
  final User user;
  const AdminNotificationPageChild({Key key, this.user}) : super(key: key);
  final Map<String, IconData> symbol = const {
    'class': Icons.schedule,
    'post': Icons.assignment,
    'admin': Icons.assignment_ind
  };
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
              print(snapshot.error);
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else if (snapshot.data == null) {
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else {
              if (snapshot.data.length == 0) {
                return Center(
                    child: Text(
                  'Empty',
                  style: TextStyle(fontSize: 30),
                ));
              }
              snapshot.data.sort();
              List reveseList = List.from(snapshot.data.reversed);
              return ListView.separated(
                itemCount: reveseList.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(reveseList[index].title),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange[900],
                      child: Icon(symbol[reveseList[index].type]),
                      foregroundColor: Colors.white,
                    ),
                    subtitle: Text(reveseList[index].detail,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  );
                },
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminNotificationSendPage(user: user),
          ));
        },
        icon: Icon(Icons.add),
        label: Text('Send'),
        elevation: 10,
      ),
    );
  }
}
