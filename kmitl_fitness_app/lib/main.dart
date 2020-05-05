import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/locator.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:kmitl_fitness_app/util/manager/dialog_manager.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

FirebaseMessaging firebaseMessaging = FirebaseMessaging();
StreamController<int> resfreshStream = StreamController();
void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new KmitlFitnessApp());
  });
}

class KmitlFitnessApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KMITL FITNESS',
        theme: ThemeData(
            primaryColor: Colors.orange[900], accentColor: Colors.orange[900]),
        builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(
                  child: widget,
                ),
              ),
            ),
        home: MultiProvider(
          providers: [
            StreamProvider<User>(
              create: (context) => AuthenModel().user,
            ),
            StreamProvider<int>(
              create: (context) => resfreshStream.stream,
              updateShouldNotify: (oldValue, newValue) => true,
            )
          ],
          child: SelectPage(),
        ));
  }
}

class SelectPage extends StatelessWidget {
  const SelectPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = Provider.of<int>(context);
    print('refresh here by value : $refresh');
    final user = Provider.of<User>(context);
    print("User stream run here");
    try {
      if (user != null) {
        firebaseMessaging.getToken().then((token) async {
          final userModel = UserModel(uid: user.uid);
          await userModel
              .updateUserData({'fcmToken': token, 'isSignedIn': true}, null);
        });
        final adminUserModel = UserModel(uid: user.uid);
        return FutureBuilder(
          future: adminUserModel.getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Scaffold(
                  body: SafeArea(
                      child:
                          Center(child: LoadingWidget(height: 50, width: 50))));
            } else if (snapshot.data == null) {
              print('Its error here');
              print(snapshot.error);
              return Scaffold(
                  body: SafeArea(
                      child:
                          Center(child: LoadingWidget(height: 50, width: 50))));
            } else {
              if (snapshot.data.role == 'admin') {
                return AdminNavigationWidget(user: user);
              } else {
                if (snapshot.data.faceId != '' &&
                    snapshot.data.faceId != null) {
                  return NavigationWidget(user: user);
                } else {
                  return FaceIdPage(user: user);
                }
              }
            }
          },
        );
      } else {
        return LoginPage();
      }
    } catch (error) {
      resfreshStream.add(-1);
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingWidget(
          width: 50,
          height: 50,
        ),
      );
    }
  }
}
