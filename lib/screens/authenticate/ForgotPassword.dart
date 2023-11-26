 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  String email = '';

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }
  Future passwordReset() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Password reset link sent! Check your email'),
                );
              }
          );
    } on FirebaseAuthException catch (e) {
      // print(e);
      showDialog(
          context: context,
          builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
      ),
      body: Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Enter your email and will send you a passeord reset',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _emailController,
              decoration: textInputDecoration.copyWith(hintText: 'E-mail'),
              validator: (val) => val!.isEmpty ? 'Enter an email' : null ,
              onChanged: (val){
                setState(() {
                  email = val;
                });
              },
            ),
            SizedBox(height: 20,),
            MaterialButton(
              onPressed: passwordReset,
              child: Text(
                'Reset password',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.pink[400],
            )
          ],
        ),
      )

    );
  }
}
