import 'package:flutter/material.dart';

class AdminRewardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminRewardPageChild();
  }
}

class AdminRewardPageChild extends State<AdminRewardPage>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.white,
          ),
          title: Text(
            "Reward",
            style: TextStyle(color: Colors.white, fontSize: 25),
            textAlign: TextAlign.left,
          ),
          backgroundColor: Colors.orange[900],
        ),
        body: Container(
          height:MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 0,
                child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.stars,
                      color: Colors.orange[900],
                    ),
                    Text(
                      "300",
                      style: TextStyle(fontSize: 23),
                    )
                  ],
                )),
              ),
              Expanded(
                child: Container(
                //height: MediaQuery.of(context).size.height * 0.8,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    GridView.count(
                      physics: ScrollPhysics(),
                      primary: true,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(19, (index) {
                        return Card(
                          elevation: 5.0,
                          child: InkWell(
                            onTap: () => {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height*0.126,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/example.jpg'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text('ส่วนลด $index %',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text("ใช้  $index point"),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                )),
              ),
              ),
              
            ],
          ),
        ));
  }
}


