import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_reward_adding_page.dart';
import 'package:kmitl_fitness_app/ui/pages/admin_reward_detail_page.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AdminRewardPage extends StatefulWidget {
  final User user;

  const AdminRewardPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AdminRewardPageChild(user: user);
  }
}

class AdminRewardPageChild extends State<AdminRewardPage> {
  final User user;
  RewardModel rewardModel;
  AdminRewardPageChild({this.user});

  @override
  void initState() {
    super.initState();
    rewardModel = RewardModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AdminRewardAddingPage(user: user),
            ));
          },
          icon: Icon(Icons.add),
          label: Text('Create'),
          elevation: 10,
        ),
        body: StreamBuilder(
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
                  widgets.add(Container(
                    child: Card(
                      elevation: 5.0,
                      margin: EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return AdminRewardDetailPage(
                                user: user, reward: snapshot.data[i]);
                          }));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
            }));
  }
}
