import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AdminRewardUserList extends StatelessWidget {
  final User user;
  final Reward reward;
  AdminRewardUserList({Key key, this.user, this.reward}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminRewardUserListChild(user: user, reward: reward);
  }
}

class AdminRewardUserListChild extends StatefulWidget {
  final User user;
  final Reward reward;
  const AdminRewardUserListChild({Key key, this.user, this.reward})
      : super(key: key);
  @override
  _AdminRewardUserListChildState createState() =>
      _AdminRewardUserListChildState(user: user, reward: reward);
}

class _AdminRewardUserListChildState extends State<AdminRewardUserListChild> {
  final List<String> items = List<String>.generate(17, (i) => "User ${++i}");
  List<Map<String, dynamic>> persons;
  final User user;
  final Reward reward;
  RewardModel rewardModel;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _AdminRewardUserListChildState({this.user, this.reward});

  @override
  void initState() {
    super.initState();
    rewardModel = RewardModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Reward user list'),
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
                reward.title,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
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
                        future: rewardModel.getPersons(reward.id),
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
                                      onChanged: snapshot.data[index]['isChecked']
                                          ? null
                                          : (bool value) {
                                              setState(() {
                                                persons[index]['isChecked'] =
                                                    value;
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
              Center(
                child: ButtonTheme(
                  minWidth: 200,
                  height: 45,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: RaisedButton(
                    onPressed:() async {
                            setState(() {
                              _isLoading = true;
                            });
                            final result = await rewardModel.checkPersons(
                                reward.id, persons);
                            setState(() {
                              _isLoading = false;
                            });
                            if (result == 0) {
                              print('check class success');
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Check user list success"),
                                backgroundColor: Colors.green,
                              ));
                            } else {
                              print('check class failed');
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Check user list failed please try again"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                    color: Colors.orange[900],
                    child: Text(
                      'Save',
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
