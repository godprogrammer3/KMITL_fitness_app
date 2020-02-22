import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartPageChild();
  }
}

class StartPageChild extends StatelessWidget {
  const StartPageChild({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/start_page_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:MediaQuery.of(context).size.height * 0.4),
              Text('KMITL',
                  style: TextStyle(
                      color: Color.fromARGB(255,255, 111, 0),
                      fontFamily: 'Roboto',
                      fontSize: 60)),
              Text('FITNESS',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Roboto', fontSize: 60)),
              SizedBox(height: 80),
              MaterialButton(
                  height: MediaQuery.of(context).size.width * 0.118,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  color: Color.fromARGB(255,255, 111, 0),
                  textColor: Colors.white,
                  child: Text('Login',style: TextStyle(
                      color: Colors.white, fontFamily: 'Roboto', fontSize: 20,)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                        )
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(34.0),
                      side: BorderSide(color: Colors.transparent))),
              SizedBox(height: 15),
              MaterialButton(
                  height: MediaQuery.of(context).size.width * 0.118,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.white,
                  textColor: Color.fromARGB(255,255, 111, 0),
                  child: Text('Sign up',style: TextStyle(
                      color: Color.fromARGB(255,255, 111, 0), fontFamily: 'Roboto', fontSize: 20,)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                        )
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(34.0),
                      side: BorderSide(color: Colors.transparent))),
            ],
          ),
        ),
      ),
    );
  }
}
