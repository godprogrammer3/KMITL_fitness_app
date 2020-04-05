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
  final List<String> items = List<String>.generate(20, (i) => "News: ${++i}");

  @override
  void initState() {
    super.initState();
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NotificationPage();
              }));
            },
            color: Colors.orange[900],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (contex, index) {
          return SizedBox(
            height: 320,
            child: Card(
              child: InkWell(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsDetailPage(),
                  ))
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 240.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/example.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("${items[index]}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("${items[index]}"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
