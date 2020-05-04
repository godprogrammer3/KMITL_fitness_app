import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/loading_widget.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
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
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            _button(context),
          ],
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
                final result = await postModel.deletePost(post.id);
                if( result == 0){
                  print('delete post success');
                  Navigator.of(context).pop();
                }else{
                  print('delete post failed');
                }
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
                Map<String, dynamic> data = {
                  'title': _titleController.text,
                  'detail': _detailController.text,
                };
                final realImage = await imageFile;
                await postModel.updatePost(post.id, data, realImage);
                print('update post success');
                Navigator.of(context).pop();
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
}
