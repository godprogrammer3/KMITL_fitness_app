import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/authen_model.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:kmitl_fitness_app/main.dart';

class FaceIdPage extends StatelessWidget {
  final User user;
  FaceIdPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FaceIdPageChild(user: user);
  }
}

class FaceIdPageChild extends StatefulWidget {
  final User user;
  FaceIdPageChild({Key key, this.user}) : super(key: key);

  @override
  _FaceIdPageChildState createState() => _FaceIdPageChildState(user: user);
}

class _FaceIdPageChildState extends State<FaceIdPageChild> {
  final User user;
  File faceIDwithCroped;
  final faceDetector = FirebaseVision.instance.faceDetector();
  _FaceIdPageChildState({this.user});
  String _showText = '';
  bool _isCanSave = false;
  bool _isLoading = false;
  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    if (picture != null) {
      setState(() {
        _isLoading = true;
      });
      final result = await _processImage(picture);
      setState(() {
        _isLoading = false;
      });
      if (result == 0) {
        print('detect face success');
        setState(() {
          _isCanSave = true;
        });
      } else {
        print('detect none face or mutiple face');
        setState(() {
          _isCanSave = false;
          _showText = 'detect none face or mutiple face';
        });
      }
    } else {
      setState(() {
        _isCanSave = false;
        _showText = 'Image not selected';
      });
    }
  }

  Future<int> _processImage(File imageIn) async {
    List<Face> faces =
        await faceDetector.processImage(FirebaseVisionImage.fromFile(imageIn));
    if (faces.length == 1) {
      final data = await imageIn.readAsBytes();
      final image = ImageProcess.copyCrop(
          ImageProcess.decodeImage(data),
          faces[0].boundingBox.left.toInt(),
          faces[0].boundingBox.top.toInt(),
          faces[0].boundingBox.width.toInt(),
          faces[0].boundingBox.height.toInt());
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      var filePath = tempPath + '/tmp_' + DateTime.now().toString() + '.png';
      faceIDwithCroped =
          await File(filePath).writeAsBytes(ImageProcess.encodePng(image));
      setState(() {
        faceIDwithCroped = faceIDwithCroped;
      });
      return 0;
    } else {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Face Id'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () async {
            await AuthenModel().signOut();
          },
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: LoadingOverlay(
            isLoading: _isLoading,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("Signup finished please add face id before."),
                IconButton(
                    icon: Icon(Icons.center_focus_weak),
                    iconSize: 80,
                    onPressed: () {
                      _openCamera(context);
                    }),
                (_isCanSave)
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Image.file(faceIDwithCroped))
                    : Container(
                        child: Text(_showText),
                      ),
                RaisedButton(
                  onPressed: (_isCanSave)
                      ? () async {
                          setState(() {
                            _isLoading = true;
                          });
                          final result = await UserModel(uid: user.uid)
                              .updateFaceId(faceIDwithCroped);
                          setState(() {
                            _isLoading = false;
                          });
                          if (result == 0) {
                            print('saved face id success');
                            resfreshStream.add(1);
                          } else {
                            print('saved face id failed');
                          }
                        }
                      : null,
                  child: Text('Save'),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
