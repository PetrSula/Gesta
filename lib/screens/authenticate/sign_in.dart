import 'package:flutter/material.dart';
import 'package:my_app_2/screens/authenticate/register.dart';
import 'package:my_app_2/services/auth.dart';
import 'package:my_app_2/shared/loading.dart';

import '../../shared/constants.dart';
import 'ForgotPassword.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String pasword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign in to Brew Crew'),
        actions: [
          TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
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

                decoration:  textInputDecoration.copyWith(hintText: 'E-mail'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null ,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration:  textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null ,
                onChanged: (val){
                  setState(() {
                    pasword = val;
                  });
                },
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 20),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ForgotPassword();
                        },
                        ),
                        );
                      },
                      child: Text('Forgot Password?',
                        style: TextStyle(
                          color: Colors.pink[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });;
                    dynamic result = await _auth.signInWithEmailAndPassword(email, pasword);
                    if (result == null){
                      setState(() {
                        loading = false;
                        error = 'Something go wrong';
                      });
                    }
                  }
                },
                child: Text(
                  'Sign in',
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
