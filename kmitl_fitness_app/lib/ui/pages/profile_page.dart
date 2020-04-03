import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/membership_page.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfilePageChild();
  }
}

class ProfilePageChild extends StatefulWidget {
 
  @override
  _ProfilePageStateChild createState() => _ProfilePageStateChild();
}

class _ProfilePageStateChild extends State<ProfilePageChild> {
  final authenModel = AuthenModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.orange[900]),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.orange[900],
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.portrait,size: 100,),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Username",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FlatButton(
                      onPressed: ()=>{},
                      child: Text("Edit Profile")
                    )
                  ],
                )
              ],
            ),
            Container(
              child: FlatButton(
                onPressed: () => {},
                child: Text("Point: 200                                                             "),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                )
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () => {Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MembershipPage(),
                  ))},
                child: Text("Membership                                                         "),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                )
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () => {},
                child: Text("About                                                                     "),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                )
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () async {
                  await authenModel.signOut();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
