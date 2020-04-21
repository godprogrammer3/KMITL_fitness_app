import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutPage extends StatelessWidget {
  final User user;
  const AboutPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutPageChild();
  }
}

class AboutPageChild extends StatefulWidget {
  final User user;
  const AboutPageChild({Key key, this.user}) : super(key: key);

  @override
  _AboutPageChildState createState() => _AboutPageChildState();
}

class _AboutPageChildState extends State<AboutPageChild> {
  final User user;
  _AboutPageChildState({this.user});

  Set<Marker> _markers = HashSet<Marker>();

  GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('0'),
        position: LatLng(13.72872017, 100.77529085),
        infoWindow: InfoWindow(
          title: 'KMITL Fitness Center',
          snippet: 'โรงอาหาร L ชั้น 2',
        ),
      ));
    });
  }

  String phoneNumber = 'tel:0837476791';
  String instagram = 'https://www.instagram.com/puriwatwijitthunyaroj';
  String facebook = 'https://www.facebook.com';
  String line = 'https://line.me/th';

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/flutter.jpg'),
              radius: 75,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'KMITL Fitness Center App',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'About us...',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _launchInApp(instagram);
                  },
                  child: Icon(
                    FontAwesome.instagram,
                    size: 50,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchInApp(facebook);
                  },
                  child: Icon(
                    AntDesign.facebook_square,
                    size: 50,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchInApp(phoneNumber);
                  },
                  child: Icon(
                    FontAwesome.phone,
                    size: 50,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: 350,
              //color: Colors.black54,
              decoration: BoxDecoration(border: Border.all()),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(13.72872538, 100.77528226),
                  zoom: 17,
                ),
              ),
            ),
            Text(
              'โรงอาหาร L ชั้น 2',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
