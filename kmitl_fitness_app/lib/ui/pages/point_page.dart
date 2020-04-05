import 'package:flutter/material.dart';

class PointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PointPageChild();
  }
}

class PointPageChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              print("back");
            },
            color: Colors.orange[900],
          ),
          title: (Text(
            "Reward",
            style: TextStyle(color: Colors.orange[900], fontSize: 25),
            textAlign: TextAlign.left,
          )),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.stars,
                  color: Colors.orange[900],
                ),
                Text(
                  "295",
                  style: TextStyle(fontSize: 23),
                )
              ],
            )),
            SizedBox(
              height: 20.0,
            ),
            GridView.count(
              primary: true,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(20, (index) {
                return Card(
                  elevation: 5.0,
                  child: InkWell(
                    onTap: () => {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/example.jpg'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('ส่วนลด $index %',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("ใช้  $index point"),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        )));
  }
}

//Row(children: <Widget>[Icon(Icons.stars), Text("295")],)
