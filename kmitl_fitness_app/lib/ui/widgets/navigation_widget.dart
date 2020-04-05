import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/main.dart';

class NavigationWidget extends StatelessWidget {
  final User user;
  NavigationWidget({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NavigationChild(user: user);
  }
}

class NavigationChild extends StatefulWidget {
  final User user;

  const NavigationChild({Key key, this.user}) : super(key: key);
  @override
  _NavigationStateChild createState() => _NavigationStateChild(user: user);
}

class _NavigationStateChild extends State<NavigationChild> {
  final User user;
  int _selectedIndex = 0;
  var _pageOptions;

  _NavigationStateChild({this.user});

  @override
  void initState() {
    super.initState();
    initFirebaseMessaging();
    _pageOptions = [
      HomePage(),
      ClassPage(user:user),
      LockerPage(),
      TreadmillPage(user: user),
      ProfilePage()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initFirebaseMessaging() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessageInNavigation: $message");
        setState(() {
          _selectedIndex = 3;
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunchInNavigation: $message");
        setState(() {
          _selectedIndex = 3;
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResumeInNavigation: $message");
        setState(() {
          _selectedIndex = 3;
        });
      },
    );
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
