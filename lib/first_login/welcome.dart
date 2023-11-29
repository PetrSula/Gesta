import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/choose_sex.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}


class _WelcomeState extends State<Welcome> {

  void onIconClicked() {
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => Choose_sex(),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome Screen'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0), // Adjust the spacing
                Text(
                  'Your additional text here',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onIconClicked,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 50.0, // Adjust the icon size
                          color: Colors.blue, // Adjust the icon color
                        ),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
