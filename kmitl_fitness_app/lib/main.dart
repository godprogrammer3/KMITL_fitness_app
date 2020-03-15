import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

void main() {
  runApp(KmitlFitnessApp());
}

class KmitlFitnessApp extends StatelessWidget {
  
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'KMITL FITNESS',
      theme: ThemeData(
        primaryColor: Colors.orange[900],
      ),
      home: ApiTestPage(),
    );
  }
}

