import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MembershipPage extends StatefulWidget {
  final User user;

  const MembershipPage({Key key, this.user}) : super(key: key);
  @override
  _MembershipPageState createState() => _MembershipPageState(user: user);
}

class _MembershipPageState extends State<MembershipPage> {
  final User user;
  PackageModel packageModel;
  _MembershipPageState({this.user});
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('can not launch url :' + url);
    }
  }

  @override
  void initState() {
    super.initState();
    packageModel = PackageModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Membership"),
      ),
      body: StreamBuilder(
          stream: packageModel.packages,
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 280,
                    child: Card(
                      margin: EdgeInsets.all(20.0),
                      child: Container(
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        snapshot.data[index].detail
                                            .replaceAll('\\n', '\n'),
                                        style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ]),
                                Column(
                                  children: <Widget>[
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(
                                        '฿' +
                                            snapshot.data[index].price
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '/' + snapshot.data[index].period,
                                      style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 20,
                                          height: 0.75),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      '฿' +
                                          snapshot.data[index].pricePerDay
                                              .toString() +
                                          ' ต่อวัน',
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 200,
                              height: 45,
                              child: FlatButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      final url =
                                          'https://kmitlfitnessapp.web.app/payment?amount=' +
                                              (snapshot.data[index].price * 100)
                                                  .toInt()
                                                  .toString() +
                                              '&userId=' +
                                              user.uid +
                                              '&packageId=' +
                                              snapshot.data[index].id
                                                  .toString();
                                      print('URL');
                                      return PaymentPage(url: url);
                                    }));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                  color: Colors.orange[800],
                                  child: Text(
                                    "GET",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

class MemberPackage {
  String title;
  String detail;
  String price;
  String time;
  String pricePerDay;
  MemberPackage(
      {this.title, this.detail, this.price, this.time, this.pricePerDay});
}
