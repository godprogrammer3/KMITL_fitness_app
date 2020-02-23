import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  ListItem({Key key, 
  @required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title),
    );
  }
}