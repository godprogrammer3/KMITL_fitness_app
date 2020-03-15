import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/pages.dart';
import 'ui/pages/pages.dart';

void main() {
  runApp(KmitlFitnessApp());
}

class KmitlFitnessApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KMITL FITNESS',
      theme: ThemeData(
        primaryColor: Colors.orange[900],
      ),
      home: TreadmillPage(),
    );
  }
}
