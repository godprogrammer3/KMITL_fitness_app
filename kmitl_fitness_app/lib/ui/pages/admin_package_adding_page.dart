import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/package_model.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AdminPackageAddingPage extends StatefulWidget {
  final User user;

  AdminPackageAddingPage({Key key, this.user}) : super(key: key);

  @override
  _AdminPackageAddingPageState createState() =>
      _AdminPackageAddingPageState(user: user);
}

class _AdminPackageAddingPageState extends State<AdminPackageAddingPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _detailController = TextEditingController();

  final TextEditingController _periodController = TextEditingController();

  final TextEditingController _totalDayController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _pricePerDayController = TextEditingController();

  bool _isLoading = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final User user;

  _AdminPackageAddingPageState({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        title: Text('Add Package'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.all(20),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      TextFormField(
                        maxLength: 50,
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
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
                        maxLength: 200,
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
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Detail is required';
                          } else if (value.length < 3 || value.length > 200) {
                            return 'Detail must between 3 and 200 letter';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        maxLength: 50,
                        controller: _periodController,
                        decoration: InputDecoration(
                          labelText: 'Period',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Period is required';
                          } else if (value.length < 3 || value.length > 50) {
                            return 'Period must between 3 and 50 letter';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        controller: _totalDayController,
                        decoration: InputDecoration(
                          labelText: 'Total Day',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Total day is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp(r"[0-9.]"))
                        ],
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Price is required';
                          } else if (double.tryParse(value) == null) {
                            return 'Input a valid price';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 60,
                        child: FlatButton(
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text("Please fill up the form correctly"),
                                  backgroundColor: Colors.red,
                                ));
                                return;
                              }
                              final packageModel =
                                  PackageModel(uid: widget.user.uid);
                              Map<String, dynamic> data = {
                                'title': _titleController.text,
                                'detail': _detailController.text,
                                'period': _periodController.text,
                                'totalDay': int.parse(_totalDayController.text),
                                'price': double.parse(_priceController.text),
                                'pricePerDay':
                                    double.parse(_priceController.text) /
                                        double.parse(_priceController.text),
                              };
                              setState(() {
                                _isLoading = true;
                              });
                              final result = await packageModel.create(data);
                              setState(() {
                                _isLoading = false;
                              });
                              if (result == 0) {
                                print('creat package success');
                                Navigator.of(context).pop();
                              } else {
                                print('creat package faild');
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Create package failed please try again"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(color: Colors.transparent)),
                            color: Colors.orange[900],
                            child: Text(
                              "CREATE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
