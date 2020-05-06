import 'package:dropdown_formfield/dropdown_formfield.dart';
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
  List<TimeAttendanceChartData> _listData, _savelistData;
  String fillterType = 'รวมทั้งหมด';
  int fillterYear = -1, fillterMonth = -1, fillterDay = -1;
  List<Map<String, dynamic>> listYear, listMonth, listDay;
  int sum = 0;
  _AdminUserLogPageStateChild({this.user});
  void _processChart() {
    if (fillterType == 'รวมทั้งหมด') {
      sum = 0;
      for (var i in _savelistData) {
        sum += i.totalPerson;
      }
      setState(() {
        sum = sum;
        _listData = _savelistData;
      });
    } else if (fillterType == 'รายปี') {
      sum = 0;
      for (var i in _savelistData) {
        if (i.date.year == fillterYear) {
          sum += i.totalPerson;
        }
      }
      setState(() {
        sum = sum;
      });
    } else if (fillterType == 'รายเดือน') {
      sum = 0;
      for (var i in _savelistData) {
        if (i.date.year == fillterYear && i.date.month == fillterMonth) {
          sum += i.totalPerson;
        }
      }
      setState(() {
        sum = sum;
      });
    } else {
      sum = 0;
      for (var i in _savelistData) {
        if (i.date.year == fillterYear &&
            i.date.month == fillterMonth &&
            i.date.day == fillterDay) {
          sum += i.totalPerson;
          break;
        }
      }
      setState(() {
        sum = sum;
      });
    }
  }

  void _updateList(String caller) {
    listYear = List<Map<String, dynamic>>();
    Set<int> setYear = Set<int>();
    for (var i in _savelistData) {
      setYear.add(i.date.year);
    }
    final sortListYear = setYear.toList();
    sortListYear.sort();
    if (fillterYear < 0) {
      fillterYear = sortListYear.last;
    }
    for (var i in sortListYear) {
      listYear.add({
        'display': i.toString(),
        'value': i,
      });
    }
    listMonth = List<Map<String, dynamic>>();
    Set<int> setMonth = Set<int>();
    for (var i in _savelistData) {
      if (i.date.year == fillterYear) {
        setMonth.add(i.date.month);
      }
    }
    final sortListMonth = setMonth.toList();
    sortListMonth.sort();
    if (fillterMonth < 0 || caller == 'year') {
      fillterMonth = sortListMonth.last;
    }
    for (var i in sortListMonth) {
      listMonth.add({
        'display': i.toString(),
        'value': i,
      });
    }
    listDay = List<Map<String, dynamic>>();
    Set<int> setDay = Set<int>();
    for (var i in _savelistData) {
      if (i.date.year == fillterYear && i.date.month == fillterMonth) {
        setDay.add(i.date.day);
      }
    }
    final sortListDay = setDay.toList();
    sortListDay.sort();
    if (fillterDay < 0 || caller == 'month' || caller == 'year') {
      fillterDay = sortListDay.last;
    }
    for (var i in sortListDay) {
      listDay.add({
        'display': i.toString(),
        'value': i,
      });
    }
    setState(() {
      setYear = setYear;
      setMonth = setMonth;
      setDay = setDay;
    });
  }

  Widget _buildFillter(BuildContext context) {
    _updateList('builder');
    if (fillterType != 'รวมทั้งหมด') {
      if (fillterType == 'รายปี') {
        return Row(
          children: <Widget>[
            Expanded(
              child: DropDownFormField(
                titleText: 'Year',
                hintText: 'Please choose one',
                value: fillterYear,
                onChanged: (value) {
                  setState(() {
                    fillterYear = value;
                  });
                  _processChart();
                },
                dataSource: listYear,
                textField: 'display',
                valueField: 'value',
              ),
            ),
          ],
        );
      } else if (fillterType == 'รายเดือน') {
        return Row(
          children: <Widget>[
            Expanded(
              child: DropDownFormField(
                titleText: 'Month',
                hintText: 'Please choose one',
                value: fillterMonth,
                onChanged: (value) {
                  setState(() {
                    fillterMonth = value;
                  });
                  _updateList('month');
                  _processChart();
                },
                dataSource: listMonth,
                textField: 'display',
                valueField: 'value',
              ),
            ),
            Expanded(
              child: DropDownFormField(
                titleText: 'Year',
                hintText: 'Please choose one',
                value: fillterYear,
                onChanged: (value) {
                  setState(() {
                    fillterYear = value;
                  });
                  _updateList('year');
                  _processChart();
                },
                dataSource: listYear,
                textField: 'display',
                valueField: 'value',
              ),
            ),
          ],
        );
      } else {
        return Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: DropDownFormField(
                titleText: 'Day',
                hintText: '',
                value: fillterDay,
                onChanged: (value) {
                  setState(() {
                    fillterDay = value;
                  });
                  _updateList('day');
                  _processChart();
                },
                dataSource: listDay,
                textField: 'display',
                valueField: 'value',
              ),
            ),
            Expanded(
              flex: 2,
              child: DropDownFormField(
                titleText: 'Month',
                hintText: '',
                value: fillterMonth,
                onChanged: (value) {
                  setState(() {
                    fillterMonth = value;
                  });
                  _updateList('month');
                  _processChart();
                },
                dataSource: listMonth,
                textField: 'display',
                valueField: 'value',
              ),
            ),
            Expanded(
              flex: 2,
              child: DropDownFormField(
                titleText: 'Year',
                hintText: '',
                value: fillterYear,
                onChanged: (value) {
                  setState(() {
                    fillterYear = value;
                  });
                  _updateList('year');
                  _processChart();
                },
                dataSource: listYear,
                textField: 'display',
                valueField: 'value',
              ),
            ),
          ],
        );
      }
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: Text(
                  'จำนวนคนเข้าใช้',
                  style: TextStyle(fontSize: 30, fontFamily: 'Kanit'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: FutureBuilder(
                      future:
                          TimeAttendanceModel().getAllTimeAttendanceChartData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: LoadingWidget(height: 50, width: 50));
                        } else if (snapshot.data == null) {
                          return Center(
                              child: LoadingWidget(height: 50, width: 50));
                        } else {
                          snapshot.data.sort();
                          if (_listData == null) {
                            _listData = snapshot.data;
                            _savelistData = _listData;
                            for (var i in _listData) {
                              sum += i.totalPerson;
                            }
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                sum = sum;
                              });
                            });
                          }
                          return charts.TimeSeriesChart(
                            [
                              charts.Series<TimeAttendanceChartData, DateTime>(
                                data: snapshot.data,
                                domainFn:
                                    (TimeAttendanceChartData datum, int index) {
                                  return datum.date;
                                },
                                id: 'time_attendance_chart',
                                measureFn:
                                    (TimeAttendanceChartData datum, int index) {
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
              Column(
                children: <Widget>[
                  DropDownFormField(
                    titleText: 'Fillter type',
                    hintText: 'Please choose one',
                    value: fillterType,
                    onChanged: (value) {
                      setState(() {
                        fillterType = value;
                      });
                      _processChart();
                    },
                    dataSource: [
                      {
                        "display": "รายวัน",
                        "value": "รายวัน",
                      },
                      {
                        "display": "รายเดือน",
                        "value": "รายเดือน",
                      },
                      {
                        "display": "รายปี",
                        "value": "รายปี",
                      },
                      {
                        "display": "รวมทั้งหมด",
                        "value": "รวมทั้งหมด",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                  (_listData != null) ? _buildFillter(context) : Container(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'จำนวน : ' + sum.toString() + ' คน',
                      style: TextStyle(fontSize: 25, fontFamily: 'Kanit'),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}
