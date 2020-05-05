import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/loading_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AdminPostEditingPage extends StatefulWidget {
  final Post post;

  const AdminPostEditingPage({Key key, this.post}) : super(key: key);
  @override
  _AdminPostEditingPageState createState() =>
      _AdminPostEditingPageState(post: post);
}

class _AdminPostEditingPageState extends State<AdminPostEditingPage> {
  Future<File> imageFile;
  final Post post;
  PostModel postModel;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _AdminPostEditingPageState({this.post});

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
          return FutureBuilder(
              future: PostModel(uid: post.owner).getUrlFromImageId(post.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(child: LoadingWidget(height: 50, width: 50));
                } else if (snapshot.data == null) {
                  return Center(child: LoadingWidget(height: 50, width: 50));
                } else {
                  return Image.network(
                    snapshot.data,
                    fit: BoxFit.fitWidth,
                  );
                }
              });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = post.title;
    _detailController.text = post.detail;
    postModel = PostModel(uid: post.owner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.orange[900],),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Stack(alignment: Alignment.center, children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.4,
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
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                _button(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Row(
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
                final result = await showPopup(context, post.id);
                if(result == 0){
                  Navigator.of(context).pop();
                }
                setState(() {
                  _isLoading = false;
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.transparent)),
              color: Colors.black,
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
                if (_formKey.currentState.validate()) {
                  Map<String, dynamic> data = {
                    'title': _titleController.text,
                    'detail': _detailController.text,
                  };
                  final realImage = await imageFile;
                  setState(() {
                    _isLoading = true;
                  });
                  final result =
                      await postModel.updatePost(post.id, data, realImage);
                  setState(() {
                    _isLoading = false;
                  });
                  if (result == 0) {
                    print('update post success');
                    Navigator.of(context).pop();
                  } else {
                    print('update post failed');
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Update post failed please try again"),
                      backgroundColor: Colors.red,
                    ));
                  }
                } else {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text("Please fill up the form the form correctly"),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.transparent)),
              color: Colors.orange[900],
              child: Text(
                "SAVE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }

  Future<int> showPopup(BuildContext context, String postId) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 20,
        title: Text(
          'ลบโพสต์?',
          style: TextStyle(fontSize: 30, fontFamily: 'Kanit'),
        ),
        content: Text(
          'คุณแน่ใจหรือไม่ที่จะทำการลบโพสต์ ' + post.title,
          style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'ไม่',
              style: TextStyle(
                  fontSize: 20, fontFamily: 'Kanit', color: Colors.black54),
            ),
            onPressed: () {
              Navigator.of(context).pop(-1);
            },
          ),
          FlatButton(
            child: Text(
              'ใช่',
              style: TextStyle(
                  fontSize: 20, fontFamily: 'Kanit', color: Colors.orange[900]),
            ),
            onPressed: () async {
              final result = await postModel.deletePost(postId);
              if (result == 0) {
                print('delete class success');
                Navigator.of(context).pop(0);
              } else {
                print('delete class faild');
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Delete post failed please try again."),
                  backgroundColor: Colors.red,
                ));
                Navigator.of(context).pop(-1);
              }
            },
          ),
        ],
      ),
    );
  }
}
