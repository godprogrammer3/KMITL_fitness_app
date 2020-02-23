import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NavigationChild();
  }
}
class NavigationChild extends StatefulWidget {
  @override
  _NavigationStateChild createState() => _NavigationStateChild();
}

class _NavigationStateChild extends State<NavigationChild> {
  int _selectedIndex = 0;
  final _pageOptions = [
    HomePage(),
    ClassPage(),
    LockerPage(),
    TreadmillPage(),
    ProfilePage()
  ];

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
        onTap: (index){_onItemTapped(index);},
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
