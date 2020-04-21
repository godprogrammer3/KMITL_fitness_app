import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
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
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/post01.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Text(
                '3 STEPS เทคนิคฟิตหุ่นให้ลีน แบบนางงาม',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Text(
                '''
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
''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Kanit'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
