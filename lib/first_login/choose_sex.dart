import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/welcome.dart';

class Choose_sex extends StatefulWidget {
  const Choose_sex({super.key});

  @override
  State<Choose_sex> createState() => _Choose_sexState();
}

class _Choose_sexState extends State<Choose_sex> {
  String? _selectedGender;

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
              Text(
                'Your additional text here',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => Welcome(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                              Icons.arrow_forward,
                              size: 50.0, // Adjust the icon size
                              color: Colors.blue), // Adjust the icon colo),
                          onPressed: () {
                            // Handle right arrow button press
                          },
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
