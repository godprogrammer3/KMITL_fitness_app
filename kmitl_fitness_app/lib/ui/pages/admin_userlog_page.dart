import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Data2 {
  final int year;
  final int sales;

  Data2(this.year, this.sales);
}

final data2 = [
  new Data2(0, 1500000),
  new Data2(1, 1735000),
  new Data2(2, 1678000),
  new Data2(3, 1890000),
  new Data2(4, 1907000),
  new Data2(5, 2300000),
  new Data2(6, 2360000),
  new Data2(7, 1980000),
  new Data2(8, 2654000),
  new Data2(9, 2789070),
  new Data2(10, 3020000),
  new Data2(11, 3245900),
  new Data2(12, 4098500),
  new Data2(13, 4500000),
  new Data2(14, 4456500),
  new Data2(15, 3900500),
  new Data2(16, 5123400),
  new Data2(17, 5589000),
  new Data2(18, 5940000),
  new Data2(19, 6367000),
];

_getSeriesData() {
  List<charts.Series<Data2, int>> series = [
    charts.Series(
        id: "Sales",
        data: data2,
        domainFn: (Data2 series, _) => series.year,
        measureFn: (Data2 series, _) => series.sales,
        colorFn: (Data2 series, _) =>
            charts.MaterialPalette.blue.shadeDefault)
  ];
  return series;
}

class AdminUserLogPage extends StatelessWidget {
  final User user;
  AdminUserLogPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminUserLogPageChild(user: user);
  }
}

class AdminUserLogPageChild extends StatefulWidget {
  final User user;
  const AdminUserLogPageChild({Key key, this.user}) : super(key: key);
  @override
  _AdminUserLogPageStateChild createState() =>
      _AdminUserLogPageStateChild(user: user);
}

class _AdminUserLogPageStateChild extends State<AdminUserLogPageChild> {
  final authenModel = AuthenModel();
  final User user;

  _AdminUserLogPageStateChild({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'จำนวนผู้เข้าใช้งานในเดือน',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton<String>(
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              Text(
                '500',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Center(
                child: Text(
                  'จำนวนคนเข้าใช้',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
                child: Container(
                  height: 150.0,
                  child: new charts.LineChart(
                    _getSeriesData(),
                    animate: true,
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
