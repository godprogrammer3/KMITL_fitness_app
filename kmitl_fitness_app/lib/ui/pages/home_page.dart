import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageChild();
  }
}

class HomePageChild extends StatefulWidget {
  @override
  _HomePageStateChild createState() => _HomePageStateChild();
}

class _HomePageStateChild extends State<HomePageChild> {
  final List<String> items = List<String>.generate(3, (i) => 'i');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NotificationPage();
              }));
            },
            color: Colors.white,
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
        itemCount: items.length,
        itemBuilder: (contex, index) {
          return Column(
            children: <Widget>[
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PostDetailPage(),
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200.0,
                        //width: 300.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/post01.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('3 STEPS เทคนิคฟิตหุ่นให้ลีน แบบนางงาม',
                            style: TextStyle(
                                height: 2,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit')),
                        subtitle: Text(
                          'ก่อนอื่นต้องยินดีกับนักเรียนของเรา น้องฟ้าใส ที่ได้รางวัล Golden Tiara Ticket ในรายการ...',
                          style: TextStyle(fontFamily: 'Kanit'),
                        ),
                      ),
                      Divider(),
                      Text('อ่านต่อ',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                              color: Colors.orange[900])),
                      SizedBox(height: 10.0)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0)
            ],
          );
        },
      ),
    );
  }
}
