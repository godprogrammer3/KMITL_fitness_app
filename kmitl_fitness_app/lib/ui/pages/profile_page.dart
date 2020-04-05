import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/models/models.dart';
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
      body: Center(child:
      RaisedButton(
        onPressed: () async {
          await authenModel.signOut();
        },
        child: Text('Log out')
      ),
      ),
    );
  }
}
