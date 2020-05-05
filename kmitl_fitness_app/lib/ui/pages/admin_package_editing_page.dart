import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AdminPackageEditingPage extends StatefulWidget {
  final User user;
  final Package package;
  AdminPackageEditingPage({Key key, this.user, this.package}) : super(key: key);
  @override
  _AdminPackageEditingPageState createState() =>
      _AdminPackageEditingPageState(user: user, package: package);
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
  PackageModel packageModel;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    packageModel = PackageModel(uid: user.uid);
  }

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
        title: Text('Edit Package'),
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
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        controller: _pricePerDayController,
                        decoration: InputDecoration(
                          labelText: 'Price per day',
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
                            return 'Price per day is required';
                          } else if (double.tryParse(value) == null) {
                            return 'Input a valid price per day';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: 140,
                            child: FlatButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final result =
                                      await createAlertDialog(context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (result == 0) {
                                    print('delete package success');
                                    Navigator.of(context).pop();
                                  } else if (result == -1) {
                                    return;
                                  } else {
                                    print('delete package failed');
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Deletete package failed please try again"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side:
                                        BorderSide(color: Colors.transparent)),
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
                                onPressed: () async {
                                  if (!_formKey.currentState.validate()) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Please fill up the form correctly"),
                                      backgroundColor: Colors.red,
                                    ));
                                    return;
                                  }
                                  final packageModel =
                                      PackageModel(uid: user.uid);
                                  Map<String, dynamic> data = {
                                    'title': _titleController.text,
                                    'detail': _detailController.text,
                                    'period': _periodController.text,
                                    'totalDay':
                                        int.parse(_totalDayController.text),
                                    'price':
                                        double.parse(_priceController.text),
                                    'pricePerDay': double.parse(
                                        _pricePerDayController.text),
                                  };
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final result = await packageModel.update(
                                      package.id, data);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (result == 0) {
                                    print('update package success');
                                    Navigator.of(context).pop();
                                  } else {
                                    print('update package faild');
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Update package failed please try again"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side:
                                        BorderSide(color: Colors.transparent)),
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
          ),
        ),
      ),
    );
  }

  Future<int> createAlertDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete this package?"),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop(-1);
                  }),
              MaterialButton(
                  elevation: 5.0,
                  child: Text("DELETE"),
                  onPressed: () async {
                    final result = await packageModel.delete(package.id);
                    if (result == 0) {
                      print('delete package success');
                      
                      Navigator.of(context).pop(0);
                    } else {
                      print('delete package failed');
                      Navigator.of(context).pop(-2);
                    }
                  })
            ],
          );
        });
  }
}
