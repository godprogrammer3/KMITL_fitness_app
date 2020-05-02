import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/data/entitys/user.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';


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
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.transparent,
      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         RaisedButton(
      //           onPressed: () async {
      //             final result = await TimeAttendanceModel().getAllTimeAttendanceChartData();
      //             setState(() {
      //               _timeAttendanceChartDatas = result;
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
                  child: FutureBuilder(
                      future: TimeAttendanceModel().getAllTimeAttendanceChartData(),
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
                              charts.Series<TimeAttendanceChartData, DateTime>(
                                data: snapshot.data,
                                domainFn: (TimeAttendanceChartData datum, int index) {
                                  return datum.date;
                                },
                                id: 'time_attendance_chart',
                                measureFn: (TimeAttendanceChartData datum, int index) {
                                  return datum.totalPerson;
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
