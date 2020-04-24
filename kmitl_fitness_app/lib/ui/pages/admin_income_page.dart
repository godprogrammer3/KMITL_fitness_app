import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}

final data = [
  new SalesData(0, 1500000),
  new SalesData(1, 1735000),
  new SalesData(2, 1678000),
  new SalesData(3, 1890000),
  new SalesData(4, 1907000),
  new SalesData(5, 2300000),
  new SalesData(6, 2360000),
  new SalesData(7, 1980000),
  new SalesData(8, 2654000),
  new SalesData(9, 2789070),
  new SalesData(10, 3020000),
  new SalesData(11, 3245900),
  new SalesData(12, 4098500),
  new SalesData(13, 4500000),
  new SalesData(14, 4456500),
  new SalesData(15, 3900500),
  new SalesData(16, 5123400),
  new SalesData(17, 5589000),
  new SalesData(18, 5940000),
  new SalesData(19, 6367000),
];

_getSeriesData() {
  List<charts.Series<SalesData, int>> series = [
    charts.Series(
        id: "Sales",
        data: data,
        domainFn: (SalesData series, _) => series.year,
        measureFn: (SalesData series, _) => series.sales,
        colorFn: (SalesData series, _) =>
            charts.MaterialPalette.blue.shadeDefault)
  ];
  return series;
}

class AdminIncomePage extends StatelessWidget {
  final User user;
  AdminIncomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminIncomePageChild(user: user);
  }
}

class AdminIncomePageChild extends StatefulWidget {
  final User user;
  const AdminIncomePageChild({Key key, this.user}) : super(key: key);
  @override
  _AdminIncomePageStateChild createState() =>
      _AdminIncomePageStateChild(user: user);
}

class _AdminIncomePageStateChild extends State<AdminIncomePageChild> {
  final authenModel = AuthenModel();
  final User user;

  _AdminIncomePageStateChild({this.user});
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
                'รายได้ของเดือน',
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
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'รายได้',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Container(
              height: 150.0,
              child: new charts.LineChart(
                _getSeriesData(),
                animate: true,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
