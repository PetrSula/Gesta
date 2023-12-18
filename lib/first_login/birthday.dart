import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/Frequenci.dart';

class Birthday extends StatefulWidget {
  const Birthday({Key? key}) : super(key: key);

  @override
  State<Birthday> createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  DateTime? partnerBirthday;
  bool recommendLater = false;

  void setPartnerBirthday(DateTime selectedDate) {
    setState(() {
      partnerBirthday = selectedDate;
    });
  }

  void nextScreen(BuildContext context) {
    // Navigate to the next screen
    Example:
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => Frequency()),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        partnerBirthday = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Birthday of Partner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Partner\'s Birthday:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            partnerBirthday != null
                                ? "${partnerBirthday!.day}/${partnerBirthday!.month}/${partnerBirthday!.year}"
                                : "Select Birthday",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Additional Text Here', // Add your additional text here
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Radio(
                  value: false,
                  groupValue: recommendLater,
                  onChanged: (bool? value) {
                    setState(() {
                      recommendLater = value ?? false;
                    });
                  },
                ),
                Text('No'),
                SizedBox(width: 20.0),
                Radio(
                  value: true,
                  groupValue: recommendLater,
                  onChanged: (bool? value) {
                    setState(() {
                      recommendLater = value ?? false;
                    });
                  },
                ),
                Text('Yes'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, left: 20.0, right: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 50.0,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                size: 50.0,
                color: Colors.blue,
              ),
              onPressed: () {
                // Call the function to navigate to the next screen
                nextScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
