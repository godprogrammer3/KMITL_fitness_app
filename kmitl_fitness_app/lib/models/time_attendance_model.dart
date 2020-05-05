import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class TimeAttendanceModel{
  final CollectionReference collection =
      Firestore.instance.collection('time_attendance');

  List<TimeAttendance> _objectFromSnapshot(QuerySnapshot snapshot){
     return snapshot.documents.map((doc) {
      return TimeAttendance(
        id: doc.documentID,
        time: DateTime.fromMillisecondsSinceEpoch((doc.data['time'].seconds*1000+doc.data['time'].nanoseconds/1000000).round()),
        user: doc.data['user'],
        type: doc.data['type'],
      );
    }).toList();
  }
  Future<List<TimeAttendanceChartData>> getAllTimeAttendanceChartData()async{
    final snapshot = await collection.getDocuments();
    final timeAttendances = _objectFromSnapshot(snapshot);
    final checkDuplicate = List<String>();
    final mapResult = Map<String,int>();
    for( var i = 0 ; i < timeAttendances.length ; i++){
      final  dateString = DateFormat('yyy-MM-dd').format(timeAttendances[i].time);
      if( timeAttendances[i].type == 'in' && !checkDuplicate.contains(dateString+timeAttendances[i].user)){
        checkDuplicate.add(dateString+timeAttendances[i].user);
        if( mapResult[dateString] == null){
          mapResult[dateString] = 1;
        }else{
          mapResult[dateString]++;
        }
      }
    }
    final result = List<TimeAttendanceChartData>();
    mapResult.forEach((k,v)=>result.add(TimeAttendanceChartData(date:DateTime.parse(k),totalPerson: v)));
    return result;

  }
}