import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app_2/screens/home/page/first_login.dart';
import 'package:my_app_2/screens/home/home.dart';
import 'package:my_app_2/screens/home/model/userSetting.dart';
import 'package:my_app_2/screens/home/service/userSetting_service.dart';

import '../../models/user.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';

class Home_switcher extends StatefulWidget {
  @override
  State<Home_switcher> createState() => _Home_switcherState();
}

class _Home_switcherState extends State<Home_switcher> {
  final AuthService _auth = AuthService();

  late StreamSubscription<MyUser?> userSubscription;

  var numberOfNotifications = -1; // Initializing to a default value

  @override
  void initState() {
    super.initState();

    userSubscription = _auth.user.listen((MyUser? user) {
      if (user != null) {
        String uid = user.uid;
        print("UID of the current user: $uid");
        _fetchUserData(uid);
      } else {
        print("User is signed out");
      }
    });
  }

  Future<void> _fetchUserData(uid) async {
    try {
      UserSettingService userSettingService = UserSettingService(uid: uid);
      UserData? userData = await userSettingService.getUserSetting();

      if (userData != null) {
        setState(() {
          numberOfNotifications = userData.frequency;
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (numberOfNotifications == 0) {
      return Home();
    } else if (numberOfNotifications > 0) {
      return User_Setting();
    } else {
      // Handle the case when numberOfNotifications is null or other values
      return Loading();
    }
  }
}