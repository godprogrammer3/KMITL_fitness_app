import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AdminRewardAddingPage extends StatefulWidget {
  final User user;

  const AdminRewardAddingPage({Key key, this.user}) : super(key: key);
  @override
  _AdminRewardAddingPageState createState() =>
      _AdminRewardAddingPageState(user: user);
}

class _AdminRewardAddingPageState extends State<AdminRewardAddingPage> {
  Future<File> imageFile;
  final User user;
  TextEditingController titleController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _AdminRewardAddingPageState({this.user});
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
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'No Image Select',
                textAlign: TextAlign.center,
              ),
            ),
          ]);
        }
      },
    );
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
                          child: showImage()),
                    ),
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
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: 'Quantity',
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
                        ),
                        SizedBox(height: 10),
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
                            }else if (value.length < 3 || value.length > 200) {
                              return 'Detail must between 3 and 200 letter';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 60,
                            child: FlatButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final realImage = await imageFile;
                                  if (realImage == null) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("Image must selected"),
                                      backgroundColor: Colors.red,
                                    ));
                                    return;
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
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
                                    'point': int.parse(pointController.text),
                                    'quantity':
                                        int.parse(quantityController.text),
                                    'detail': detailController.text,
                                  };
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final result =
                                      await rewardModel.create(data, realImage);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (result == 0) {
                                    print('create reward success');
                                    Navigator.of(context).pop();
                                  } else {
                                    print('create reward failed');
                                     _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Create reward failed please try again"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                color: Colors.orange[900],
                                child: Text(
                                  "CREATE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
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
