import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ApiTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      create: (_) => AuthenModel().user,
      child: ApiTestPageChild(),
    );
  }
}

class ApiTestPageChild extends StatefulWidget {
  const ApiTestPageChild({Key key}) : super(key: key);

  @override
  _ApiTestPageChildState createState() => _ApiTestPageChildState();
}

class _ApiTestPageChildState extends State<ApiTestPageChild> {
  bool _isSignUp = false;
  AuthenModel authenModel = AuthenModel();
  DatabaseModel databaseModel;
  List<TextEditingController> _textController =
      List<TextEditingController>.generate(
          6, (index) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return buildSignInOrSignUp(context);
    } else {
      return buildUserData(context, user);
    }
  }

  Widget buildSignInOrSignUp(BuildContext context) {
    if (_isSignUp == true) {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter first name'),
              controller: _textController[0],
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter last name'),
              controller: _textController[1],
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter email'),
              controller: _textController[2],
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter password'),
              controller: _textController[3],
              obscureText:true,
            ),
            RaisedButton(
                child: Text('Submit'),
                onPressed: () async {
                  print(_textController[0].text);
                  final userData = UserData(
                    firstName: _textController[0].text,
                    lastName: _textController[1].text,
                    email: _textController[2].text,
                  );
                  dynamic result = await authenModel.register(
                      userData, _textController[3].text);
                  if (result == null) {
                    print('Error could not register');
                  }
                }),
            RaisedButton(
              child: Text('Back to Sign In'),
              onPressed: () {
                setState(() => _isSignUp = false);
              },
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter email'),
              controller: _textController[4],
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter password'),
              controller: _textController[5],
              obscureText: true,
            ),
            RaisedButton(
              child: Text('Sign In'),
              onPressed: () async {
                dynamic result = await authenModel.signInWithEmailAndPassword(
                    _textController[4].text, _textController[5].text);
                if (result == null) {
                  print("Error could not sign in");
                }
              },
            ),
            RaisedButton(
              child: Text('Sign up'),
              onPressed: () {
                setState(() => _isSignUp = true);
              },
            ),
          ],
        ),
      );
    }
  }

  Widget buildUserData(BuildContext context, User user) {
    databaseModel = DatabaseModel(uid: user.uid);
    return FutureBuilder(
        future: databaseModel.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: <Widget>[
              Text('First Name: '+snapshot.data.firstName),
              Text('Last Name: '+snapshot.data.lastName),
              Text('Email: '+snapshot.data.email),
              RaisedButton(
                child: Text('Sign Out'),
                onPressed: () async {
                  await authenModel.signOut();
                },
              ),
            ]);
          } else {
            return LoadingWidget();
          }
        });
  }
}
