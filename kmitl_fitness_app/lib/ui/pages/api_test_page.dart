import 'package:flutter/material.dart';

class ApiTestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ApiTestPageChild();
  }

}

class ApiTestPageChild extends StatelessWidget {
  const ApiTestPageChild({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: buildBody(context),
      ),
      ),
    );
  }

  Widget buildBody(BuildContext context){
    return Text('Api test page.');
  }
}