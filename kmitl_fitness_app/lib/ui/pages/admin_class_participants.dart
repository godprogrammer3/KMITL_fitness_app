import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class AdminClassParticipants extends StatelessWidget {
  const AdminClassParticipants({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminClassParticipantsChild();
  }
}

class AdminClassParticipantsChild extends StatefulWidget {
  @override
  _AdminClassParticipantsChildState createState() =>
      _AdminClassParticipantsChildState();
}

class _AdminClassParticipantsChildState
    extends State<AdminClassParticipantsChild> {
  final List<String> items = List<String>.generate(17, (i) => "User ${++i}");
  final List<bool> checkBoxValue = List<bool>.generate(17, (i) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Participants'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Class Name',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'เวลา: ',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Kanit',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CheckboxListTile(
                            secondary: Icon(Icons.face),
                            title: Text(items[index].toString()),
                            value: checkBoxValue[index],
                            onChanged: (bool value) {
                              setState(() {
                                checkBoxValue[index] = value;
                              });
                            }),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ButtonTheme(
                minWidth: 200,
                height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.orange[900],
                  child: Text(
                    'บันทึกการเข้าร่วม',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Kanit',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
