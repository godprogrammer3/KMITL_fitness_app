import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminMorePage extends StatelessWidget {

  List<Widget> _pageOption = [
    AdminRewardPage(),
    AdminPackagePage()
  ];
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('More'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Reward',
              ),
              Tab(
                text: 'Package',
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
