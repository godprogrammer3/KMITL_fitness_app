import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class PointPage extends StatefulWidget {
  final User user;

  const PointPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PointPageChild(user: user);
  }
}

class PointPageChild extends State<PointPage> {
  final User user;
  RewardModel rewardModel;
  createAlertDialog(BuildContext context,String id,Reward reward) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.transparent)),
            child: Container(
              height: 450,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Center(
                        child: Image(
                          image: AssetImage('assets/images/5percent.jpg'),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(280, 1, 1, 1),
                          child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              }))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    reward.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("ใช้ "+reward.point.toString()+" point"),
                  SizedBox(height: 20),
                  Text(
                      reward.detail),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                      onPressed: () async {
                        final result = await rewardModel.redeem(id);
                        if( result == 0){
                          print('redeem reward success');
                          Navigator.of(context).pop();
                        }else{
                          print('redeem reward failed');
                          print('error code : $result');
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.transparent)),
                      color: Colors.orange[900],
                      child: Text(
                        "แลกรับ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          );
        });
  }

  PointPageChild({this.user});

  @override
  void initState() {
    super.initState();
    rewardModel = RewardModel(uid: user.uid);
  }

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
      body: StreamBuilder(
          stream: rewardModel.rewards,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: LoadingWidget(height: 50, width: 50));
            } else if (snapshot.data == null) {
              return Center(child: Text("Empty"));
            } else {
              List<Widget> widgets = List<Widget>();
              for (int i = 0; i < snapshot.data.length; i++) {
                widgets.add(Container(
                  child: Card(
                    elevation: 5.0,
                    margin: EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        createAlertDialog(context,snapshot.data[i].id,snapshot.data[i]);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder(
                            future: rewardModel
                                .getUrlFromImageId(snapshot.data[i].id),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child:
                                        LoadingWidget(height: 50, width: 50));
                              } else if (snapshot.data == null) {
                                return Center(
                                    child:
                                        LoadingWidget(height: 50, width: 50));
                              } else {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          ListTile(
                            title: Text(snapshot.data[i].title,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("ใช้  " +
                                snapshot.data[i].point.toString() +
                                " point"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
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
                              children: widgets,
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
