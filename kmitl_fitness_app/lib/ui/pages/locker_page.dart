import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/locator.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:kmitl_fitness_app/util/datamodels/dialog_type.dart';
import 'package:kmitl_fitness_app/util/services/dialog_service.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LockerPage extends StatelessWidget {
  LockerPage({Key key, this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserModel(uid: user.uid).getUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
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
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NotificationPage(user: user);
                        }));
                      },
                      color: Colors.white,
                    )
                  ],
                  backgroundColor: Colors.orange[900],
                ),
                body: Center(
                    child:
                        Center(child: LoadingWidget(height: 50, width: 50))));
          } else if (snapshot.data == null) {
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
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NotificationPage(user: user);
                        }));
                      },
                      color: Colors.white,
                    )
                  ],
                  backgroundColor: Colors.orange[900],
                ),
                body: Center(
                    child:
                        Center(child: LoadingWidget(height: 50, width: 50))));
          } else {
            final expireDate = DateTime.parse(DateFormat('yyyy-MM-dd')
                .format(snapshot.data.membershipExpireDate));
            final currentDate =
                DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
            final bool isNotExpired = currentDate.isBefore(expireDate);
            if (isNotExpired) {
              return LockerPageChild(user: user);
            } else {
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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return NotificationPage(user: user);
                          }));
                        },
                        color: Colors.white,
                      )
                    ],
                    backgroundColor: Colors.orange[900],
                  ),
                  body: Center(
                      child: Text(
                    'You not in membership',
                    style: TextStyle(fontSize: 20),
                  )));
            }
          }
        });
  }
}

class LockerPageChild extends StatefulWidget {
  final User user;
  const LockerPageChild({Key key, this.user}) : super(key: key);
  @override
  _LockerPageStateChild createState() => _LockerPageStateChild(user: user);
}

class _LockerPageStateChild extends State<LockerPageChild> {
  final User user;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _LockerPageStateChild({this.user});
  LockerModel lockerModel;
  TextEditingController textController = TextEditingController();
  final dialogService = locator<DialogService>();
  void checkPincode(String lockerId) async {
    final response = await dialogService
        .showDialog(dialogType: InputTextDialog(), parameters: {
      'title': 'Please Enter Pin Code',
      'textInButton': 'Submit',
      'content': TextFormField(
        textAlign: TextAlign.center,
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        controller: textController,
      ),
      'uid': user.uid
    });

    if (response.confirmed) {
      print('confirmed');
      setState(() {
        _isLoading = true;
      });
      final result =
          await lockerModel.verifyPincode(textController.text, lockerId);
      setState(() {
        _isLoading = false;
      });
      if (result == 0) {
        print('verify success');
      } else if (result == -2) {
        print('verify fail');
        print('error code : $result');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Verify pin failed pin is incorrect"),
          backgroundColor: Colors.red,
        ));
      } else {
        print('verify fail');
        print('error code : $result');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Verify pin failed please try again"),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      print('unconfirmed');
    }
  }

  @override
  void initState() {
    super.initState();
    lockerModel = LockerModel(uid: user.uid);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Locker',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NotificationPage(user: user);
              }));
            },
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: StreamBuilder(
            stream: lockerModel.lockers,
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return LoadingWidget(height: 50, width: 50);
              } else if (asyncSnapshot.data == null) {
                return Center(child: Text("Empty data!"));
              } else {
                List<Locker> lockers = new List<Locker>();
                for (var i in asyncSnapshot.data) {
                  if (i.id != 'pinCode') {
                    lockers.add(i);
                  }
                }
                for (var i in lockers) {
                  if (i.user == user.uid) {
                    return controlLocker(context, i.isLocked);
                  }
                }
                return selectLocker(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget selectLocker(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(
            "Choose your locker",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 300,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: StreamBuilder(
                stream: lockerModel.lockers,
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return LoadingWidget(height: 50, width: 50);
                  } else if (asyncSnapshot.data == null) {
                    return LoadingWidget(height: 50, width: 50);
                  } else {
                    List<Locker> lockers = new List<Locker>();
                    for (var i in asyncSnapshot.data) {
                      if (i.id != 'pinCode') {
                        lockers.add(i);
                      }
                    }
                    return GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: List.generate(9, (index) {
                          return FlatButton(
                            onPressed: lockers[index].user != ''
                                ? null
                                : () {
                                    checkPincode(index.toString());
                                  },
                            child: Column(children: <Widget>[
                              Icon(
                                Icons.lock,
                                size: 40,
                                color: lockers[index].user != ''
                                    ? Colors.black
                                    : Colors.green,
                              ),
                              Text(
                                'No. ' + (index + 1).toString(),
                                style: TextStyle(color: Colors.black87),
                              ),
                            ]),
                          );
                        }));
                  }
                },
              ),
            ),
          ),
        ]));
  }

  Widget controlLocker(BuildContext context, bool isLocked) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            isLocked ? 'Your locker is LOCKED' : 'Your locker is UNLOCKED',
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLocked ? Icons.lock : Icons.lock_open,
              size: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AnimatedContainer(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: isLocked ? Colors.grey[600] : Colors.orange[900],
                borderRadius: BorderRadius.all(Radius.circular(100))),
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: FlatButton(
                onPressed: () async {
                  if (isLocked) {
                    setState(() {
                      _isLoading = true;
                    });
                    final result = await lockerModel.open();
                    setState(() {
                      _isLoading = false;
                    });
                    if (result == 0) {
                      print('open success');
                    } else {
                      print('open failed');
                      print('error code : $result');
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("Open locker failed please try again"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    final result = await lockerModel.lock();
                    setState(() {
                      _isLoading = false;
                    });
                    if (result == 0) {
                      print('close success');
                    } else {
                      print('close failed');
                      print('error code : $result');
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("Close locker failed please try again"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  isLocked ? 'UNLOCK' : 'LOCK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: FlatButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  final result = await lockerModel.returnLocker();
                  setState(() {
                    _isLoading = false;
                  });
                  if (result == 0) {
                    print('return success');
                  } else {
                    print('return failed');
                    print('error code: $result');
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Return locker failed please try again"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  'Return',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
