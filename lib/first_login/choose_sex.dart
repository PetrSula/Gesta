import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/second_text.dart';
import 'package:my_app_2/first_login/welcome.dart';
import 'package:my_app_2/models/partner.dart';

class Choose_sex extends StatefulWidget {
  final PartnerData partnerData;

  const Choose_sex({Key? key, required this.partnerData}) : super(key: key);

  @override
  State<Choose_sex> createState() => _Choose_sexState();
}

class _Choose_sexState extends State<Choose_sex> {
  String? _selectedGender;

 void NextScreen() {
   widget.partnerData.gender = _selectedGender ?? '';

   Navigator.push(
     context,
     CupertinoPageRoute(
       builder: (context) => Second_Text(partnerData: widget.partnerData),
     ),
   ).then((returnedData) {
     if (returnedData != null) {
       PartnerData updatedPartnerData = returnedData as PartnerData;
       if (updatedPartnerData.gender.isNotEmpty) {
         _selectedGender = updatedPartnerData.gender;
       }
     }
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose gender'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: _selectedGender,
                items: [
                  DropdownMenuItem<String>(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                hint: Text('Select gender'),
              ),
              SizedBox(height: 20.0), // Adding space between dropdown and text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut elit non nisi. Nullam nec fermentum elit. Integer luctus augue a libero dictum, vel suscipit ligula laoreet. Morbi varius, justo a dictum varius, justo mi eleifend ligula',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                              Icons.arrow_back,
                              size: 50.0, // Adjust the icon size
                              color: Colors.blue),
                          onPressed: ()  {
                            Navigator.pop( context);
                            //     context,
                            //     MaterialPageRoute(
                            //     builder: (context) => Welcome(),
                            //   ),
                            // );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                              Icons.arrow_forward,
                              size: 50.0, // Adjust the icon size
                              color: Colors.blue), // Adjust the icon colo),
                          onPressed: NextScreen,
                        ),
                      ],
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