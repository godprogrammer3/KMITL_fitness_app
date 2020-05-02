import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';

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
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.transparent,
      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         RaisedButton(
      //           onPressed: () async {
      //             final result = await IncomeModel().getAllIncomeChartData();
      //             setState(() {
      //               _incomeChartDatas = result;
      //             });
      //           },
      //           child: Text('test api'),
      //         ),
      //       ],
      //     ),
      //   ),
      //   elevation: 0,
      // ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'จำนวนรายได้',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: Container(
                  height: 150.0,
                  child: FutureBuilder(
                      future: IncomeModel().getAllIncomeChartData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: LoadingWidget(height: 50, width: 50));
                        } else if (snapshot.data == null) {
                          return Center(
                              child: LoadingWidget(height: 50, width: 50));
                        } else {
                          return charts.TimeSeriesChart(
                            [
                              charts.Series<IncomeChartData, DateTime>(
                                data: snapshot.data,
                                domainFn: (IncomeChartData datum, int index) {
                                  return datum.date;
                                },
                                id: 'income_chart',
                                measureFn: (IncomeChartData datum, int index) {
                                  return datum.value;
                                },
                              )
                            ],
                            animate: true,
                            defaultRenderer: new charts.LineRendererConfig(
                                includePoints: true),
                          );
                        }
                      }),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
