import 'package:flutter/material.dart';
import 'package:my_app_2/screens/authenticate/register.dart';
import 'package:my_app_2/screens/authenticate/sign_in.dart';


class Authenticate extends StatefulWidget {
  // const ({super.key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSingIn = true;
  void toggleView() {
    setState(() {
      showSingIn = !showSingIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSingIn){
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
    // return Container(
    //   child: Register(),
    // );
  }
}
