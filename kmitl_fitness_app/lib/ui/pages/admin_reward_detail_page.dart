import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
  TextEditingController percentController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String rewardType = 'discount';
  _AdminRewardDetailPageState({this.user, this.reward});
  Future<int> createAlertDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete this reward?"),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.pop(context, -1);
                  }),
              MaterialButton(
                  elevation: 5.0,
                  child: Text("DELETE"),
                  onPressed: () async {
                    Navigator.pop(context, 0);
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
    rewardType = reward.type;
    percentController.text = reward.percent.toString();
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
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.orange[900],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(alignment: Alignment.center, children: <Widget>[
                    Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: showImage())),
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
                        TextFormField(
                          maxLength: 50,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: 'Title',
                          ),
                          controller: titleController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Title is required';
                            } else if (value.length < 3 || value.length > 50) {
                              return 'Title must between 3 and 50 letter';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: 'Point',
                          ),
                          controller: pointController,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Point is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        (rewardType == 'goods')
                            ? TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false, decimal: false),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: 'Quantity',
                                ),
                                controller: quantityController,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Quantity is required';
                                  }
                                  return null;
                                },
                              )
                            : Container(),
                        (rewardType == 'discount')
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false, decimal: true),
                                  controller: percentController,
                                  decoration: InputDecoration(
                                    labelText: 'Percent',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter(
                                        RegExp(r"[0-9.]"))
                                  ],
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Percent is required';
                                    } else if (double.tryParse(value) == null) {
                                      return 'PLease input a valid percent';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            : Container(),
                        TextFormField(
                          maxLength: 200,
                          keyboardType: TextInputType.multiline,
                          maxLines: 7,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: 'Detail',
                          ),
                          controller: detailController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Detail is required';
                            } else if (value.length < 3 || value.length > 200) {
                              return 'Detail must between 3 and 200 letter';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            (reward.type == 'goods')
                                ? Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      height: 60,
                                      child: FlatButton(
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                              return AdminRewardUserList(
                                                  user: user, reward: reward);
                                            }));
                                           
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              side: BorderSide(
                                                  color: Colors.transparent)),
                                          color: Colors.orange[900],
                                          child: Text(
                                            "LIST",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  )
                                : Container(),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                height: 60,
                                child: FlatButton(
                                    onPressed: () async {
                                      final resultDialog =
                                          await createAlertDialog(context);
                                      if (resultDialog == 0) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        final result =
                                            await rewardModel.delete(reward.id);
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        if (result == 0) {
                                          print('delete reward success');
                                          Navigator.of(context).pop();
                                        } else {
                                          print('delete reward failed');
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Delete reward failed please try again"),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        side: BorderSide(
                                            color: Colors.transparent)),
                                    color: Colors.red,
                                    child: Text(
                                      "DELETE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                height: 60,
                                child: FlatButton(
                                    onPressed: () async {
                                      if (reward.owner != user.uid) {
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Save failed you are not owner"),
                                          backgroundColor: Colors.red,
                                        ));
                                        return;
                                      }
                                      if (!_formKey.currentState.validate()) {
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Please fill up the form correctly"),
                                          backgroundColor: Colors.red,
                                        ));
                                        return;
                                      }
                                      final rewardModel =
                                          RewardModel(uid: user.uid);
                                      Map<String, dynamic> data = {
                                        'title': titleController.text,
                                        'point':
                                            int.parse(pointController.text),
                                        'quantity':
                                            int.parse(quantityController.text),
                                        'detail': detailController.text,
                                      };
                                      if (rewardType == 'discount') {
                                        data['percent'] = double.parse(
                                            percentController.text);
                                        data['quantity'] = 1;
                                      } else {
                                        data['percent'] = 0.00;
                                        data['quantity'] =
                                            int.parse(quantityController.text);
                                      }
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final realImage = await imageFile;
                                      final result = await rewardModel.update(
                                          reward.id, data, realImage);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      if (result == 0) {
                                        print('update reward success');
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text("Updated reward success"),
                                          backgroundColor: Colors.green,
                                        ));
                                      } else {
                                        print('update reward failed');
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Updatedreward failed please try again"),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        side: BorderSide(
                                            color: Colors.transparent)),
                                    color: Colors.green,
                                    child: Text(
                                      "SAVE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
