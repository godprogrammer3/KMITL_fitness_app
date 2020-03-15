import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';

class DatabaseModel {

  final String uid;
  DatabaseModel({ this.uid });

  // collection reference
  final CollectionReference kmitlFitnessCollection = Firestore.instance.collection('kmitl_fitness');

  Future<void> updateUserData(UserData userData) async {
    return await kmitlFitnessCollection.document(uid).setData({
      'firstName': userData.firstName,
      'lastName': userData.lastName,
      'email': userData.email,
    });
  }

  Future<UserData> getUserData() async {
    UserData result = await kmitlFitnessCollection.document(uid).get().then((documentSnapshot){
      Map document = documentSnapshot.data;
      return UserData(
        uid:uid,
        firstName:document['firstName'],
        lastName:document['lastName'],
        email:document['email'],
      );
    });
    return result;
  }

}