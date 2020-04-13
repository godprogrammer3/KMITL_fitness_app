import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

import 'package:kmitl_fitness_app/ui/pages/pages.dart';


class AdminNavigationWidget extends StatelessWidget {
  final User user;
  AdminNavigationWidget({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdminNavigationChild(user: user);
  }
}

class AdminNavigationChild extends StatefulWidget {
  final User user;

  const AdminNavigationChild({Key key, this.user}) : super(key: key);
  @override
  _AdminNavigationStateChild createState() => _AdminNavigationStateChild(user: user);
}

class _AdminNavigationStateChild extends State<AdminNavigationChild> {
  final User user;
  int _selectedIndex = 0;
  var _pageOptions;
  _AdminNavigationStateChild({this.user});

  @override
  void initState() {
    super.initState();
    _pageOptions = [
      AdminStatisticPage(),
      ClassPage(user: user),
      LockerPage(user: user),
      TreadmillPage(user: user),
      AdminProfilePage(user: user)
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.orange[900],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Class'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key),
            title: Text('Locker'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            title: Text('Treadmill'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
