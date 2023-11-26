import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/models/user.dart';
import 'package:my_app_2/screens/home/home.dart';
import 'package:my_app_2/services/auth.dart';
import 'package:provider/provider.dart';

import '../../../services/database.dart';
import '../model/userSetting.dart';
import '../service/userSetting_service.dart';

class User_Setting extends StatefulWidget {
  @override
  _User_SettingState createState() => _User_SettingState();

}

class _User_SettingState extends State<User_Setting> {
  String uid = '';
  String? selectedGender;
  String partnerName = '';
  DateTime? partnerBirthday;
  DateTime? anniversaryDate;
  int numberOfNotifications = 0;

  final AuthService _auth = AuthService();

  late StreamSubscription<MyUser?> userSubscription;



  @override
  void initState() {
    super.initState();;

    // Listen to the user stream to get real-time updates about the authentication state
    userSubscription = _auth.user.listen((MyUser? user) {
      if (user != null) {
        // Access the UID of the current user
        uid = user.uid;
        print("The UID of the current user: $uid");
      } else {
        // The user is signed out
        print("User is signed out");
      }
    });

  }

  void setSelectedGender(String? gender) {
    setState(() {
      selectedGender = gender;
    });
  }
  void setPartnerName(String name) {
    setState(() {
      partnerName = name;
    });
  }
  void setPartnerBirthday(DateTime selectedDate) {
    setState(() {
      partnerBirthday = selectedDate;
    });
  }

  void setAnniversaryDate(DateTime selectedDate) {
    setState(() {
      anniversaryDate = selectedDate;
    });
  }

  void incrementNotifications() {
    setState(() {
      if (numberOfNotifications < 8) {
        numberOfNotifications++;
      }
    });
  }

  void decrementNotifications() {
    setState(() {
      if (numberOfNotifications > 0) {
        numberOfNotifications--;
      }
    });
  }

  Future<void> _selectDate(BuildContext context, Function(DateTime) onDateSelected) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != null && picked != onDateSelected) {
      onDateSelected(picked);
    }
  }
  Future<void> _updateUserData() async {
    try {
      UserData updatedData = UserData(
        anniversary: anniversaryDate ?? DateTime.now(),
        birthday: partnerBirthday ?? DateTime.now(),
        frequency: numberOfNotifications,
        gender: selectedGender ?? 'Male', // Default value for gender
        userName: partnerName,
      );
      // Update user data using UserSettingService
      await UserSettingService(uid: uid).updateUserSetting(updatedData);

      // Show a snackbar or toast to indicate successful update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User data updated successfully!'),
        ),
      );
      Home();
    } catch (error) {
      print('Error updating user data: $error');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('The App'),
        backgroundColor: Colors.brown[400],
        elevation: 0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            onPressed: () async {
              await _auth.sigOut();
            },
            label: Text('logout'),
            style: TextButton.styleFrom(primary: Colors.black),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setSelectedGender(newValue);
                    },
                    items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Partner's Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setPartnerName(value);
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Partner's Birthday: "),
                      Text(
                        partnerBirthday != null
                            ? "${partnerBirthday!.day}/${partnerBirthday!.month}/${partnerBirthday!.year}"
                            : "Select Birthday",
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context, setPartnerBirthday);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Anniversary Date: "),
                      Text(
                        anniversaryDate != null
                            ? "${anniversaryDate!.day}/${anniversaryDate!.month}/${anniversaryDate!.year}"
                            : "Select Anniversary Date",
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context, setAnniversaryDate);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Number of Notifications: "),
                      Text(
                        numberOfNotifications.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        incrementNotifications();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        decrementNotifications();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _updateUserData(); // Call the method to update user data
        },
        child: Text('Update'),
      ),
    );
  }
}