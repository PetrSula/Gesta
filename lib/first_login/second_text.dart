import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/name.dart';

import '../models/partner.dart';

class Second_Text extends StatelessWidget {
  final PartnerData partnerData;


  Second_Text({required this.partnerData});

  @override
  Widget build(BuildContext context) {
    void NextScreen() {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => Name(partnerData),
        ),
      );
    }
    void goBackWithData() {
      // Pass partnerData back to the previous screen when navigating back
      Navigator.pop(context, partnerData);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Centered Text',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, left: 20.0, right: 40.0), // Adjust bottom padding and horizontal padding here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 50.0, // Adjust the icon size
                        color: Colors.blue,
                      ),
                      onPressed: goBackWithData,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 50.0, // Adjust the icon size
                        color: Colors.blue,
                      ),
                      onPressed: NextScreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}