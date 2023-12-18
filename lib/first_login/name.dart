import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/birthday.dart';

class Name extends StatefulWidget {
  const Name({Key? key}) : super(key: key);

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {

  DateTime? partnerBirthday;

  void nextScreen(BuildContext context) {
    // Navigate to the next screen
    Example:
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => Birthday()),
    );
  }

  void setPartnerBirthday(DateTime selectedDate) {
    setState(() {
      partnerBirthday = selectedDate;
    });
  }

  Future<void> _selectDate(BuildContext context, Function(DateTime) onDateSelected) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != null && picked != onDateSelected) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name *', // * Indicates mandatory field
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
              // Validate the field to ensure it's not empty
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Nickname',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your nickname',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Name-day',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name-day: "),
                      Text(
                        partnerBirthday != null
                            ? "${partnerBirthday!.day}/${partnerBirthday!.month}/${partnerBirthday!.year}"
                            : "Name-day",
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context, setPartnerBirthday);
                    },
                  ),
                ),
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
                nextScreen(context); // Call the function to navigate to the next screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
