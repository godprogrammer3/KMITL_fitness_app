import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AdminClassManagement extends StatelessWidget {
  final User user;
  const AdminClassManagement({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminClassManagementChild(user: user);
  }
}

class AdminClassManagementChild extends StatefulWidget {
  final User user;
  const AdminClassManagementChild({Key key, this.user}) : super(key: key);

  @override
  _AdminClassManagementChildState createState() =>
      _AdminClassManagementChildState(user: user);
}

class Classes {
  String title;
  TimeOfDay startTime;
  TimeOfDay endTime;
  int maximum;
  int reserved;
  bool isFull;
  String imagePath;
  String creator;

  Classes({
    this.title,
    this.startTime,
    this.endTime,
    this.maximum,
    this.reserved,
    this.isFull,
    this.imagePath,
    this.creator,
  });
}

class _AdminClassManagementChildState extends State<AdminClassManagementChild> {
  final User user;
  _AdminClassManagementChildState({this.user});

  Class classData;

  List<Classes> classes = [
    Classes(
      title: 'Yoga',
      startTime: TimeOfDay(hour: 17, minute: 0),
      endTime: TimeOfDay(hour: 18, minute: 0),
      maximum: 20,
      reserved: 17,
      isFull: false,
      imagePath: 'assets/images/YogaEx.jpg',
      creator: 'Admin A',
    ),
    Classes(
      title: 'Cardio Boxing',
      startTime: TimeOfDay(hour: 18, minute: 0),
      endTime: TimeOfDay(hour: 19, minute: 0),
      maximum: 20,
      reserved: 20,
      isFull: true,
      imagePath: 'assets/images/cardio_boxing.jpg',
      creator: 'Admin B',
    ),
    Classes(
      title: 'Dance',
      startTime: TimeOfDay(hour: 19, minute: 0),
      endTime: TimeOfDay(hour: 20, minute: 0),
      maximum: 20,
      reserved: 3,
      isFull: false,
      imagePath: 'assets/images/dance.jpg',
      creator: 'Admin C',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Class Management'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdminClassDetail(),
                  ));
                },
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(classes[index].imagePath),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            classes[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          subtitle: Text(
                            classes[index].startTime.format(context) +
                                ' - ' +
                                classes[index].endTime.format(context),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          trailing:
                              Text('Created By: ' + classes[index].creator),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 45,
                      right: 20,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: classes[index].isFull
                                ? Colors.red
                                : Colors.lightGreenAccent[700],
                          ),
                          child: Center(
                            child: Text(
                                classes[index].reserved.toString() +
                                    '/' +
                                    classes[index].maximum.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminClassEdit(),
          ));
        },
        icon: Icon(Icons.add),
        label: Text('Create'),
        elevation: 10,
      ),
    );
  }
}
