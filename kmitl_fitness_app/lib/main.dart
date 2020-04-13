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
                )),
      ),
//      home: StreamProvider<User>(
//        create: (_) => AuthenModel().user,
//        child: SelectPage(),
      home: AboutPage(),
    );
  }
}

class SelectPage extends StatelessWidget {
  const SelectPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print("User stream run here");
    if (user != null) {
      firebaseMessaging.getToken().then((token) async {
        final databaseModel = DatabaseModel(uid: user.uid);
        await databaseModel.updateUserData({'fcmToken': token});
      });
      return NavigationWidget(user: user);
    } else {
      return LoginPage();
    }
  }
}
