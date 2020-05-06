import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AdminProfilePage extends StatelessWidget {
  final User user;
  AdminProfilePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminProfilePageChild(user: user);
  }
}

class AdminProfilePageChild extends StatefulWidget {
  final User user;
  const AdminProfilePageChild({Key key, this.user}) : super(key: key);
  @override
  _AdminProfilePageStateChild createState() =>
      _AdminProfilePageStateChild(user: user);
}

class _AdminProfilePageStateChild extends State<AdminProfilePageChild> {
  final authenModel = AuthenModel();
  final User user;
  UserModel userModel;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _AdminProfilePageStateChild({this.user});
  @override
  void initState() {
    super.initState();
    userModel = UserModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
      ),
      body: FutureBuilder(
          future: userModel.getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Center(child: LoadingWidget(height: 50, width: 50)));
            } else if (snapshot.data == null) {
              return Center(
                  child: Center(child: LoadingWidget(height: 50, width: 50)));
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: LoadingOverlay(
                  isLoading: _isLoading,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.account_circle,
                          size: 125,
                        ),
                      ),
                      Text(
                          snapshot.data.firstName +
                              ' ' +
                              snapshot.data.lastName,
                          style: TextStyle(color: Colors.black, fontSize: 35)),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminPasswordPage(user: user),
                          ));
                        },
                        child: Text("Password",
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 15)),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AboutPage(),
                          ));
                        },
                        child: Text("About",
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 15)),
                      ),
                      FlatButton(
                        onPressed: () async {
                          final userModel = UserModel(uid: user.uid);
                          setState(() {
                            _isLoading = true;
                          });
                          final result1 = await userModel
                              .updateUserData({'fcmToken': ''}, null);
                          if (result1 == 0) {
                            final result2 = await authenModel.signOut();
                            setState(() {
                              _isLoading = false;
                            });
                            if (result2 != 0) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Logout failed please try again"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Logout failed please try again"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Text("Logout",
                            style: TextStyle(color: Colors.red, fontSize: 15)),
                      ),
                    ],
                  )),
                ),
              );
            }
          }),
    );
  }
}
