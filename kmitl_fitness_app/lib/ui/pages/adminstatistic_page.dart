import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminStatisticPage extends StatelessWidget {
  final User user;
  final List<Widget> _pageOption = [AdminIncomePage(), AdminUserLogPage()];

  AdminStatisticPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Statistic'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Number of users',
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return AdminNotificationPage(user: user);
                }));
              },
              color: Colors.white,
            )
          ],
        ),
        body: TabBarView(children: _pageOption),
      ),
    );
  }
}
