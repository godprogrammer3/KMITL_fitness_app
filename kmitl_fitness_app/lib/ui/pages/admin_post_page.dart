import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminPostPage extends StatelessWidget {
  final User user;
  AdminPostPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminPostPageChild();
  }
}

class AdminPostPageChild extends StatefulWidget {
  @override
  _AdminPostPageStateChild createState() => _AdminPostPageStateChild();
}

class _AdminPostPageStateChild extends State<AdminPostPageChild> {
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
          'Post',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[900],
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
        itemCount: items.length,
        itemBuilder: (contex, index) {
          return Column(
            children: <Widget>[
              Card(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200.0,
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
