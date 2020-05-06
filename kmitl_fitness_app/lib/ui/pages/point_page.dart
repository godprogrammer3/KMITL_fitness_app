import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
  Future<int> createAlertDialog(
      BuildContext context, String id, Reward reward) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.transparent)),
            child: Container(
              height: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      FutureBuilder(
                          future: rewardModel.getUrlFromImageId(reward.id),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: LoadingWidget(height: 50, width: 50));
                            } else if (snapshot.data == null) {
                              return Center(
                                  child: LoadingWidget(height: 50, width: 50));
                            } else {
                              return Center(
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: CacheImage(snapshot.data),
                                ),
                              );
                            }
                          }),
                      Container(
                          margin: EdgeInsets.fromLTRB(280, 1, 1, 1),
                          child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.orange[900],
                              ),
                              onPressed: () {
                                Navigator.pop(context, -1);
                              }))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    reward.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("ใช้ " + reward.point.toString() + " point"),
                  SizedBox(height: 20),
                  Text(reward.detail),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                      onPressed: () async {
                        Navigator.of(context).pop(0);
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

  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PointPageChild({this.user});

  @override
  void initState() {
    super.initState();
    rewardModel = RewardModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: StreamBuilder(
              stream: rewardModel.rewards,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: LoadingWidget(height: 50, width: 50));
                } else if (snapshot.data == null) {
                  return Center(child: LoadingWidget(height: 50, width: 50));
                } else {
                  if (snapshot.data.length == 0) {
                    return Center(
                        child: Text(
                      'Empty',
                      style: TextStyle(fontSize: 30),
                    ));
                  }
                  snapshot.data.sort();
                  List<Widget> widgets = List<Widget>();
                  for (int i = 0; i < snapshot.data.length; i++) {
                    widgets.add(Card(
                      elevation: 5.0,
                      margin: EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () async {
                          final resultDialog = await createAlertDialog(
                              context, snapshot.data[i].id, snapshot.data[i]);
                          if (resultDialog == 0) {
                            setState(() {
                              _isLoading = true;
                            });
                            final result =
                                await rewardModel.redeem(snapshot.data[i].id);
                            setState(() {
                              _isLoading = false;
                            });
                            if (result == 0) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Redeem success"),
                                backgroundColor: Colors.green,
                              ));
                            } else if (result == -1) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Redeem failed point not enough"),
                                backgroundColor: Colors.red,
                              ));
                            } else if (result == -2) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Redeem failed reward out of stock"),
                                backgroundColor: Colors.red,
                              ));
                            } else if (result == -3) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Redeem failed you already redeem"),
                                backgroundColor: Colors.red,
                              ));
                            } else if (result == -5) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    "Redeem failed discount can use one as a time"),
                                backgroundColor: Colors.red,
                              ));
                            } else if (result == -99) {
                              return;
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Redeem failed please try again"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          } else {
                            return;
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: FutureBuilder(
                                future: rewardModel
                                    .getUrlFromImageId(snapshot.data[i].id),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                        child: LoadingWidget(
                                            height: 50, width: 50));
                                  } else if (snapshot.data == null) {
                                    return Center(
                                        child: LoadingWidget(
                                            height: 50, width: 50));
                                  } else {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              title: Text(snapshot.data[i].title,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("ใช้  " +
                                  snapshot.data[i].point.toString() +
                                  " point"),
                            ),
                          ],
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
        ),
      ),
    );
  }
}
