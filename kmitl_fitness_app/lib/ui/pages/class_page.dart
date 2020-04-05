import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

import 'pages.dart';

class ClassPage extends StatelessWidget {
  final User user;
  ClassPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassPageChild(user: user);
  }
}

class ClassPageChild extends StatefulWidget {
  final User user;

  const ClassPageChild({Key key, this.user}) : super(key: key);
  @override
  _ClassPageStateChild createState() => _ClassPageStateChild(user: user);
}

class _ClassPageStateChild extends State<ClassPageChild> {
  final List<String> items = List<String>.generate(20, (i) => "Class: ${++i}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Class',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.orange[900],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (contex, index) {
          return SizedBox(
            height: 240,
            child: Card(
              child: InkWell(
                onTap: () => {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/YogaEx.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("${items[index]}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('วันที่ 26/03/2020'),
                              Spacer()
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('เวลา 16:00 - 17:00'),
                              Spacer()
                            ],
                          ),
                        ]
                      ),
                      onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassPageDetail(),));
                      },
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
