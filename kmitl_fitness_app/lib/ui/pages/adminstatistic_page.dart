import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminStatisticPage extends StatelessWidget {
  final User user;
  final List<Widget> _pageOption = [
    AdminIncomePage(),
    AdminUserLogPage()
  ];

  AdminStatisticPage({Key key, this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          //title: Text('More'),
          title: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'UserLog',
              ),
            ],
          )
        ),
        body: TabBarView(
          children: _pageOption
        ),
      ),
    );
  }
}
