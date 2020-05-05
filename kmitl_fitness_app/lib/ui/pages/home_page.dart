import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageChild(user: user);
  }
}

class HomePageChild extends StatefulWidget {
  final User user;

  const HomePageChild({Key key, this.user}) : super(key: key);
  @override
  _HomePageStateChild createState() => _HomePageStateChild(user: user);
}

class _HomePageStateChild extends State<HomePageChild> {
  final List<String> items = List<String>.generate(3, (i) => 'i');
  final User user;
  PostModel postModel;
  _HomePageStateChild({this.user});
  @override
  void initState() {
    super.initState();
    postModel = PostModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NotificationPage(user:user);
              }));
            },
            color: Colors.white,
          )
        ],
      ),
      body: StreamBuilder(
        stream: postModel.posts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
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
            List<Post> reveseList = List.from(snapshot.data.reversed);
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
              itemCount: reveseList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetailPage(post:reveseList[index]),
                          ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                              future: postModel
                                  .getUrlFromImageId(reveseList[index].id),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(child: LoadingWidget(height: 50, width: 50));
                                } else if (snapshot.data == null) {
                                  return Center(child: LoadingWidget(height: 50, width: 50));
                                } else {
                                  return Container(
                                    height: 150.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: buildImage(snapshot),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            ListTile(
                              title: Text(
                                  reveseList[index].title,
                                  style: TextStyle(
                                      height: 2,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kanit')),
                              subtitle: Text(
                                reveseList[index].detail,
                                style: TextStyle(fontFamily: 'Kanit'),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Divider(),
                            Text('อ่านต่อ',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                    color: Colors.orange[900])),
                            SizedBox(height: 10.0)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0)
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  ImageProvider buildImage(AsyncSnapshot snapshot){
    try{ 
      return NetworkImage(snapshot.data);
    }catch(error){
      return AssetImage('assets/images/flutter.png');
    }
  }
}
