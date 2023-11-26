import 'package:flutter/material.dart';
import 'package:my_app_2/models/user.dart';
import 'package:my_app_2/screens/authenticate/authenticate.dart';
import 'package:my_app_2/screens/home/home.dart';
import 'package:my_app_2/screens/home/home_switcher.dart';
import 'package:provider/provider.dart';

class Wraper extends StatelessWidget {
  const Wraper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<MyUser?>(context);
    print(user);


    if (user == null){
      return Authenticate();
    }else{
      return Home_switcher();
    }

    // return hom eor Autehnticate

  }
}
