import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminMorePage extends StatefulWidget {
  final User user;

  AdminMorePage({Key key, this.user}) : super(key: key);

  @override
  _AdminMorePageState createState() => _AdminMorePageState(user:user);
}

class _AdminMorePageState extends State<AdminMorePage> {
  final User user;
  List<Widget> _pageOption;

  _AdminMorePageState({this.user});

  @override
  void initState(){
    super.initState();
    _pageOption = [
      AdminRewardPage(user:user),
      AdminPackagePage(user: user),
    ];
  }

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
