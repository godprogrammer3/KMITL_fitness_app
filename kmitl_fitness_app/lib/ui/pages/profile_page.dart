import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/membership_page.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  ProfilePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfilePageChild(user: user);
  }
}

class ProfilePageChild extends StatefulWidget {
  final User user;
  const ProfilePageChild({Key key, this.user}) : super(key: key);
  @override
  _ProfilePageStateChild createState() => _ProfilePageStateChild(user: user);
}

class _ProfilePageStateChild extends State<ProfilePageChild> {
  final authenModel = AuthenModel();
  final User user;
  UserModel userModel;
  _ProfilePageStateChild({this.user});
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return EditProfilePage();
                }));
              },
              color: Colors.white,
            )
          ],
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
                return SingleChildScrollView(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey,
                            child: ClipOval(
                              child: SizedBox(
                                width: 180.0,
                                height: 180.0,
                                child: (imageFile != null)
                                    ? Image.file(imageFile, fit: BoxFit.fill)
                                    : Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 100,
                                      ),
                              ),
                            )),
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          Text(
                            snapshot.data.firstName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            snapshot.data.lastName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Membership until "+DateFormat('dd/MM/yyyy').format(snapshot.data.membershipExpireDate),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.stars,
                            size: 30,
                            color: Colors.orange[900],
                          ),
                          Text(
                            snapshot.data.point.toString(),
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return PointPage(user: user);
                          }));
                        },
                        child: Text("Reward",
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 15)),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return MembershipPage(user: user);
                          }));
                        },
                        child: Text("Membership",
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 15)),
                      ),
                      FlatButton(
                        onPressed: () => {},
                        child: Text("Password",
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 15)),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return AboutPage(user: user);
                          }));
                        },
                        child: Text("About",
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 15)),
                      ),
                      FlatButton(
                        onPressed: () async {
                          final userModel = UserModel(uid: user.uid);
                          await userModel.updateUserData({'fcmToken': ''});
                          await authenModel.signOut();
                        },
                        child: Text("Logout",
                            style: TextStyle(color: Colors.red, fontSize: 15)),
                      ),
                    ],
                  )),
                );
              }
            }));
  }
}
