import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AdminPostPage extends StatelessWidget {
  final User user;
  AdminPostPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminPostPageChild(user: user);
  }
}

class AdminPostPageChild extends StatefulWidget {
  final User user;

  const AdminPostPageChild({Key key, this.user}) : super(key: key);
  @override
  _AdminPostPageStateChild createState() =>
      _AdminPostPageStateChild(user: user);
}

class _AdminPostPageStateChild extends State<AdminPostPageChild> {
  final List<String> items = List<String>.generate(3, (i) => 'i');
  final User user;

  PostModel postModel;

  _AdminPostPageStateChild({this.user});
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
          'Post',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return AdminPostAddingPage(user: user);
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[900],
      ),
      body: StreamBuilder(
        stream: postModel.posts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: LoadingWidget(height: 50, width: 50));
          } else if (snapshot.data == null) {
            return Center(child: Text("Empty data!"));
          } else {
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AdminPostEditingPage(post:snapshot.data[index]),
                          ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                              future: postModel
                                  .getUrlFromImageId(snapshot.data[index].id),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return LoadingWidget(height: 50, width: 50);
                                } else if (snapshot.data == null) {
                                  return LoadingWidget(height: 50, width: 50);
                                } else {
                                  return Container(
                                    height: 150.0,
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
                            ListTile(
                              title: Text(snapshot.data[index].title,
                                  style: TextStyle(
                                      height: 2,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kanit')),
                              subtitle: Text(
                                snapshot.data[index].detail,
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
}