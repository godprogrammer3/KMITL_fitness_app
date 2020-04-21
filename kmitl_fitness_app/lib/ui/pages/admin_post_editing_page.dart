import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kmitl_fitness_app/ui/pages/admin_post_detail_page.dart';

class AdminPostEditingPage extends StatefulWidget {
  @override
  _AdminPostEditingPageState createState() => _AdminPostEditingPageState();
}

class _AdminPostEditingPageState extends State<AdminPostEditingPage> {
  Future<File> imageFile;
  final _image = 'assets/images/post01.png';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  final _titleText = '3 STEPS เทคนิคฟิตหุ่นให้ลีน แบบนางงาม';
  final _detailText = '''
ก่อนอื่นต้องยินดีกับนักเรียนของเรา น้องฟ้าใส ที่ได้รางวัล Golden Tiara Ticket ในรายการ Miss Universe Thailand 2019 เมื่อสัปดาห์ที่ผ่านมา หลายๆคนน่าจะสงสัยว่า การเป็นนางงาม ต้องเทรนยังไง กินยังไง วันนี้ เราเอา Tips มาเล่าให้ฟังกันครับ
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
From fitjunctions.com/fasaixfasai/
''';

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
          return Image.asset(
            _image,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = _titleText;
    _detailController.text = _detailText;

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
            _Button(),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: 60,
          child: FlatButton(
              onPressed: () {},
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
              onPressed: () {},
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
