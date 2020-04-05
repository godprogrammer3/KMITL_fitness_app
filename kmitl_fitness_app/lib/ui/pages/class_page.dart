import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

class ClassPage extends StatelessWidget {
  final User user;
  ClassPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassPageChild(user: user);
  }
}

class ClassPageChild extends StatefulWidget {
  final User user;

  const ClassPageChild({Key key, this.user}) : super(key: key);
  @override
  _ClassPageStateChild createState() => _ClassPageStateChild(user: user);
}

class _ClassPageStateChild extends State<ClassPageChild> {
  TextEditingController titleControl, detailControl;
  File imgFile;
  PostModel postModel;
  final User user;

  _ClassPageStateChild({this.user});
  @override
  void initState() {
    super.initState();
    postModel = PostModel(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(children: <Widget>[
          TextField(
            controller: titleControl,
          ),
          TextField(
            controller: detailControl,
          ),
          imgFile != null
              ? Image(width: 200, height: 200, image: FileImage(imgFile))
              : Text(''),
          RaisedButton(
              onPressed: () async {
                await ImagePicker.pickImage(source: ImageSource.gallery)
                    .then((img) {
                  setState(() {
                    imgFile = img;
                  });
                });
              },
              child: Text('Choose Image')),
          RaisedButton(
              onPressed: () async {
                final Map<String, dynamic> postData = {
                  'title': 'new title',
                  'detail': 'test detail',
                };
                await postModel.creatPost(postData, imgFile);
                print("Creat post success");
              },
              child: Text('CreatPost')),
          // RaisedButton(
          //     onPressed: () async {
          //       final result =await postModel.reserveClass('Ti4mSW6djNPj65XrEaLV');
          //       if(result != 0){
          //         print('reserve class failed');
          //         print('error code $result');
          //       }else{
          //         print('reserve class success');
                  
          //       }
          //     },
          //     child: Text('reserve')),
          // RaisedButton(
          //     onPressed: () async {
          //       final result =await classModel.cancelClass('Ti4mSW6djNPj65XrEaLV');
          //       if(result != 0){
          //         print('cancel class failed');
          //         print('error code $result');
          //       }else{
          //         print('cancel class success');
                  
          //       }
          //     },
          //     child: Text('cancel')),
          StreamBuilder(
              stream: PostModel(uid: user.uid).posts,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  return  LoadingWidget(width: 100, height: 100);
                } else if (asyncSnapshot.data == null) {
                  return LoadingWidget(width: 100, height: 100);
                } else {
                  if( asyncSnapshot.data.length == 0){
                    return Text('Q empty');
                  }else{
                    List<Widget> widgets = List<Widget>();
                    for( var i in asyncSnapshot.data){
                      widgets.add(Text(i.title));
                    }
                    return Column(children: widgets);
                  }
                 
                }
              })
        ]),
      )),
    );
  }
}
