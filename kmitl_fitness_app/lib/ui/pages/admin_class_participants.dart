import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AdminClassParticipants extends StatelessWidget {
  final User user;
  final Class class_;
  AdminClassParticipants({Key key, this.user, this.class_}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminClassParticipantsChild(user: user, class_: class_);
  }
}

class AdminClassParticipantsChild extends StatefulWidget {
  final User user;
  final Class class_;
  const AdminClassParticipantsChild({Key key, this.user, this.class_})
      : super(key: key);
  @override
  _AdminClassParticipantsChildState createState() =>
      _AdminClassParticipantsChildState(user: user, class_: class_);
}

class _AdminClassParticipantsChildState
    extends State<AdminClassParticipantsChild> {
  final List<String> items = List<String>.generate(17, (i) => "User ${++i}");
  List<Map<String, dynamic>> persons;
  final User user;
  final Class class_;
  ClassModel classModel;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUserEmpty = true;
  _AdminClassParticipantsChildState({this.user, this.class_});

  @override
  void initState() {
    super.initState();
    classModel = ClassModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Class Participants'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(30),
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                class_.title,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'เวลา ' +
                    DateFormat('kk:mm').format(class_.beginDateTime) +
                    ' - ' +
                    DateFormat('kk:mm').format(class_.endDateTime) +
                    ' น.',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Kanit',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                        future: classModel.getPersons(class_.id),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: LoadingWidget(height: 50, width: 50));
                          } else if (snapshot.data == null) {
                            return Center(
                                child: LoadingWidget(height: 50, width: 50));
                          } else {
                            if (snapshot.data.length == 0) {
                              return Center(child: Text("Empty"));
                            }
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                _isUserEmpty = false;
                              });
                            });
                            if (persons == null) {
                              persons = snapshot.data;
                            }
                            return ListView.builder(
                              itemCount: persons.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CheckboxListTile(
                                      secondary: Icon(Icons.face),
                                      title: Text(persons[index]['firstName']),
                                      value: persons[index]['isChecked'],
                                      onChanged: class_.isChecked
                                          ? null
                                          : (bool value) {
                                              setState(() {
                                                persons[index]['isChecked'] =
                                                    value;
                                                print(persons[index]
                                                    ['isChecked']);
                                              });
                                            }),
                                );
                              },
                            );
                          }
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (_isUserEmpty)
                  ? Container()
                  : Center(
                      child: ButtonTheme(
                        minWidth: 200,
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: RaisedButton(
                          onPressed: class_.isChecked
                              ? null
                              : () async {
                                  if (user.uid != class_.owner) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Check class failed you are not owner"),
                                      backgroundColor: Colors.red,
                                    ));
                                    return;
                                  }
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final result = await classModel.checkPersons(
                                      class_.id, persons);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (result == 0) {
                                    print('check class success');
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("Check class success"),
                                      backgroundColor: Colors.green,
                                    ));
                                  } else {
                                    print('check class failed');
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Check class failed please try again"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                          color: Colors.orange[900],
                          child: Text(
                            class_.isChecked
                                ? 'บันทึกการเข้าร่วมแล้ว'
                                : 'บันทึกการเข้าร่วม',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Kanit',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
