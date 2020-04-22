import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/models/models.dart';

class AdminPostAddingPage extends StatefulWidget {
  final User user;

  const AdminPostAddingPage({Key key, this.user}) : super(key: key);
  @override
  _AdminPostAddingPageState createState() => _AdminPostAddingPageState(user:user);
}

class _AdminPostAddingPageState extends State<AdminPostAddingPage> {
  Future<File> imageFile;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController(); 
  final User user;

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
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Title',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
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
                              final postModel = PostModel(uid: user.uid);
                              Map<String, dynamic> data = {
                                'title':_titleController.text,
                                'detail':_detailController.text,
                              };
                              final realImage = await imageFile;
                              await postModel.creatPost(data, realImage);
                              print('create post success');
                              Navigator.of(context).pop();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(color: Colors.transparent)),
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
          ],
        ),
      ),
    );
  }
}
