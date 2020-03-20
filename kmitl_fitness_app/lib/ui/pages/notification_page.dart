import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationPageChild(
      
    );
  }
}

var messages = const[
  'My first message',
  'My second message',
  'My third message',
  'My fourth message'

];

class NotificationPageChild extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: (
              Text("Notification", style: TextStyle(color: Colors.orange[900]), textAlign: TextAlign.left,)
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
      body: ListView.separated(
        //itemCount: messages.length,
        itemCount: 21,
        separatorBuilder: (context,index)=> Divider(),
        itemBuilder: (BuildContext context, int index) {
          //var title = messages[index];
        return ListTile(     
          //trailing: Text('Z'),
          //title : Text(title),
          title : Text('Title $index'),
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text('UI', style: TextStyle(color: Colors.white),),
            
          ),
          subtitle: Text('Greyhound divisively hello coldly'),

        );
      },)
    );
  }

}