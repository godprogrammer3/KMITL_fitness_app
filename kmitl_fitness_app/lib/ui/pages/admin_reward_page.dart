import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class AdminRewardPage extends StatefulWidget {
  final User user;

  const AdminRewardPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AdminRewardPageChild(user:user);
  }
}

class AdminRewardPageChild extends State<AdminRewardPage> {
  final User user;

  AdminRewardPageChild({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Reward",
            style: TextStyle(color: Colors.white, fontSize: 25),
            textAlign: TextAlign.left,
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      GridView.count(
                        physics: ScrollPhysics(),
                        primary: true,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(3, (index) {
                          return Card(
                            elevation: 5.0,
                            child: InkWell(
                              onTap: () => {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.126,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/example.jpg'),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('ส่วนลด $index %',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text("ใช้  $index point"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}
