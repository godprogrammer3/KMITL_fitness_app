import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class AdminRewardDetailPage extends StatefulWidget {
  final User user;
  final Reward reward;
  const AdminRewardDetailPage({Key key, this.user, this.reward})
      : super(key: key);
  @override
  _AdminRewardDetailPageState createState() =>
      _AdminRewardDetailPageState(user: user, reward: reward);
}

class _AdminRewardDetailPageState extends State<AdminRewardDetailPage> {
  final User user;
  final Reward reward;
  RewardModel rewardModel;
  TextEditingController titleController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  _AdminRewardDetailPageState({this.user, this.reward});
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete this reward?"),
            //content: TextField(decoration: InputDecoration(hintText: 'POINT')),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  elevation: 5.0,
                  child: Text("DELETE"),
                  onPressed: () async {
                    final result =
                        await rewardModel.delete(reward.id);
                    if (result == 0) {
                      print('delete reward success');
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } else {
                      print('delete reward faild');
                    }
                  })
            ],
          );
        });
  }

  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
          );
        } else if (snapshot.error != null) {
          return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Error Picking Image',
                textAlign: TextAlign.center,
              ),
            ),
          ]);
        } else {
          return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            FutureBuilder(
                future: rewardModel.getUrlFromImageId(reward.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Center(
                            child: LoadingWidget(height: 50, width: 50)));
                  } else if (snapshot.data == null) {
                    return Center(
                        child: Center(
                            child: LoadingWidget(height: 50, width: 50)));
                  } else {
                    return Image.network(snapshot.data);
                  }
                }),
          ]);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    rewardModel = RewardModel(uid: user.uid);
    titleController.text = reward.title;
    pointController.text = reward.point.toString();
    quantityController.text = reward.quantity.toString();
    detailController.text = reward.detail;
  }

  @override
  void dispose() {
    titleController.dispose();
    pointController.dispose();
    quantityController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(alignment: Alignment.center, children: <Widget>[
              showImage(),
              IconButton(
                icon: Icon(Icons.add_photo_alternate),
                iconSize: 60.0,
                color: Colors.white,
                onPressed: () {
                  pickImageFromGallery(ImageSource.gallery);
                },
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Title : ' + reward.title,
                    ),
                    controller: titleController,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Point : ' + reward.point.toString(),
                    ),
                    controller: pointController,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Quantity : ' + reward.point.toString(),
                    ),
                    controller: quantityController,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Detail : ' + reward.detail,
                    ),
                    controller: detailController,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 60,
                        child: FlatButton(
                            onPressed: () {
                              createAlertDialog(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(color: Colors.transparent)),
                            color: Colors.red,
                            child: Text(
                              "DELETE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 60,
                        child: FlatButton(
                            onPressed: () async {
                              final rewardModel = RewardModel(uid: user.uid);
                              Map<String, dynamic> data = {
                                'title': titleController.text,
                                'point': int.parse(pointController.text),
                                'quantity': int.parse(quantityController.text),
                                'detail': detailController.text,
                              };
                              final realImage = await imageFile;
                              final result = await rewardModel.update(
                                  reward.id, data, realImage);
                              if (result == 0) {
                                print('update reward success');
                                Navigator.of(context).pop();
                              } else {
                                print('update reward failed');
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(color: Colors.transparent)),
                            color: Colors.green,
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
