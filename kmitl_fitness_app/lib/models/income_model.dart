import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class IncomeModel{
  final CollectionReference collection =
      Firestore.instance.collection('income');

  List<Income> _objectFromSnapshot(QuerySnapshot snapshot){
     return snapshot.documents.map((doc) {
      return Income(
        id: doc.documentID,
        time: DateTime.fromMillisecondsSinceEpoch((doc.data['time'].seconds*1000+doc.data['time'].nanoseconds/1000000).round()),
        user: doc.data['user'],
        value: doc.data['value'].toDouble(),
        packageId: doc.data['packageId'],
      );
    }).toList();
  }
  Future<List<IncomeChartData>> getAllIncomeChartData()async{
    final snapshot = await collection.getDocuments();
    final incomes = _objectFromSnapshot(snapshot);
    final mapResult = Map<String,double>();
    for( var i = 0 ; i < incomes.length ; i++){
      final  dateString = DateFormat('yyy-MM-dd').format(incomes[i].time);
      if( mapResult[dateString] == null){
        mapResult[dateString] = incomes[i].value;
      }else{
        mapResult[dateString] += incomes[i].value;
      }
    
    }
    final result = List<IncomeChartData>();
    mapResult.forEach((k,v)=>result.add(IncomeChartData(date:DateTime.parse(k),value: v)));
    return result;

  }
}