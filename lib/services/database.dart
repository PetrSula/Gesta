import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({ this.uid });

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String userName, String gender, DateTime anniversary,DateTime birthday, int frequency) async{
    return await userCollection.doc(uid).set({
      'userName': userName,
      'gender': gender,
      'anniversary': anniversary,
      'birthday':birthday,
      'frequency':frequency
    });
  }
  Future getUserData() async {
    return await userCollection.doc(uid).get();
  }

  Stream<QuerySnapshot> get users{
      return userCollection.snapshots();
  }
}