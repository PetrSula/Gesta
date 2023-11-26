import 'package:flutter/material.dart';
import 'package:my_app_2/shared/constants.dart';
import 'package:my_app_2/shared/loading.dart';

import '../../services/auth.dart';
import 'ForgotPassword.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String pasword = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign up to Brew Crew'),
        actions: [
          TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign in'),
              onPressed: (){
                widget.toggleView();
              },
              style: TextButton.styleFrom(primary: Colors.black))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'E-mail'),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null ,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null ,
                  onChanged: (val){
                    setState(() {
                      pasword = val;
                    });
                  },
                ),

                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, pasword);
                      if (result == null){
                        setState(() {
                          loading = false;
                          error = 'do something else';
                        });
                      }
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink[400]
                  ),
                ),
                SizedBox(height:12),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )
              ],
            ),
          )
      ),
    );
  }
}
