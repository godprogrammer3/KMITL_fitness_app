import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/pages/pages.dart';

class AdminPackageEditingPage extends StatefulWidget {
  final User user;
  final Package package;
  AdminPackageEditingPage({Key key, this.user, this.package}) : super(key: key); 
  @override
  _AdminPackageEditingPageState createState() => _AdminPackageEditingPageState(user:user,package:package);
}

class _AdminPackageEditingPageState extends State<AdminPackageEditingPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _totalDayController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _pricePerDayController = TextEditingController();
  final User user;
  final Package package;

  _AdminPackageEditingPageState({this.user, this.package});
  @override
  void initState() {
    super.initState();
     _titleController.text = package.title;
    _detailController.text = package.detail;
    _priceController.text = package.price.toString();
    _periodController.text = package.period;
    _pricePerDayController.text = package.pricePerDay.toString();
    _totalDayController.text = package.totalDay.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        title: Text('Edit Package'),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
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
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Detail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _periodController,
                  decoration: InputDecoration(
                    labelText: 'Period',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 10),
                TextField(
                  controller: _totalDayController,
                  decoration: InputDecoration(
                    labelText: 'Total Day',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _pricePerDayController,
                  decoration: InputDecoration(
                    labelText: 'Price per day',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 140,
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
                      height: 60,
                      width: 140,
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

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
