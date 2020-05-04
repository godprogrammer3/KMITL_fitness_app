import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/models/models.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AdminPostAddingPage extends StatefulWidget {
  final User user;

  const AdminPostAddingPage({Key key, this.user}) : super(key: key);
  @override
  _AdminPostAddingPageState createState() =>
      _AdminPostAddingPageState(user: user);
}

class _AdminPostAddingPageState extends State<AdminPostAddingPage> {
  Future<File> imageFile;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final User user;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _AdminPostAddingPageState({this.user});
  pickImageFromGallery(ImageSource source) async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(alignment: Alignment.center, children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: showImage()),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: 'Title',
                          ),
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
                          controller: _detailController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: 'Detail',
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Detail is required';
                            } else if (value.length < 3 || value.length > 500) {
                              return 'Detail must between 3 and 500 letter';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
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
                                    if (_formKey.currentState.validate()) {
                                      final postModel =
                                          PostModel(uid: user.uid);
                                      Map<String, dynamic> data = {
                                        'title': _titleController.text,
                                        'detail': _detailController.text,
                                      };
                                      final result = await postModel.creatPost(
                                          data, realImage);
                                      if (result == 0) {
                                        print('create post success');
                                        Navigator.of(context).pop();
                                      } else {
                                        print('create post failed');
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Create post failed please try again."),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Please fill up the form the form correctly"),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                  color: Colors.orange[900],
                                  child: Text(
                                    "POST",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
