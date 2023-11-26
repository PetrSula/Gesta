import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/userSetting.dart';


class UserSettingService{
  final String? uid;
  UserSettingService({ this.uid });

  Future<UserData?> getUserSetting() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDocument =
      await FirebaseFirestore.instance.collection('user').doc(uid).get();
      if (userDocument.exists) {
        // Convert Firestore data to UserData object using fromJson constructor
        return UserData.fromJson(userDocument.data()!);
      } else {
        return null; // Document doesn't exist
      }
    } catch (e) {
      // Handle errors or exceptions, e.g., print an error message
      print('Error fetching user document: $e');
      rethrow; // Throw the caught exception again for the caller to handle if needed
    }
  }
  Future<void> updateUserSetting(UserData updatedData) async {
    try {
      // Convert UserData object to a Map using toJson method
      final Map<String, dynamic> data = updatedData.toJson();

      // Update the document with the new data
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .set(data, SetOptions(merge: true)); // Merge data with existing document

      print('User data updated successfully');
    } catch (e) {
      // Handle errors or exceptions
      print('Error updating user document: $e');
      rethrow; // Throw the caught exception again for the caller to handle if needed
    }
  }
}