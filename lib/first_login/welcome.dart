import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/choose_sex.dart';

import '../models/partner.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}


class _WelcomeState extends State<Welcome> {
  late PartnerData _partnerData;

  void onIconClicked() {
    _partnerData = PartnerData(
      gender: '', // Assign the selected gender to PartnerData
      name: '', // Add other fields as needed, initialized to empty for now
      nickname: '',
      nameDay: null,
      anniversary: null,
      importantDay: null,
    );

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Choose_sex(partnerData: _partnerData), // Correct the parameter name here
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
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0), // Adjust the spacing
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut elit non nisi. Nullam nec fermentum elit. Integer luctus augue a libero dictum, vel suscipit ligula laoreet. Morbi varius, justo a dictum varius, justo mi eleifend ligula',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
