import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/birthday.dart';

import '../models/partner.dart';

class Name extends StatefulWidget {
  final PartnerData partnerData; // Accept partnerData in the constructor

  Name(this.partnerData);

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {

  DateTime? partnerNameDay;
  bool dontCelebrateNameDay = false;
  bool dontKnowDate = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check if there is data in PartnerData for NameDay and set partnerNameDay accordingly
    if (widget.partnerData.nameDay != null) {
      setState(() {
        partnerNameDay = widget.partnerData.nameDay;
      });
    }
    if (widget.partnerData.name != null){
      setState(() {
        nameController.text = widget.partnerData.name;
      });
    }
    if (widget.partnerData.nickname != null){
      setState(() {
        nicknameController.text = widget.partnerData.nickname;
      });
    }
  }


  void nextScreen(BuildContext context) {
    widget.partnerData.name = nameController.text;
    widget.partnerData.nickname = nicknameController.text;
    if (partnerNameDay != null) {
      widget.partnerData.nameDay = partnerNameDay;
    }
    // Navigate to the next screen
    Example:
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => Birthday( partnerData: widget.partnerData)),
    );
  }

  void goBackWithData() {
    widget.partnerData.name = nameController.text;
    widget.partnerData.nickname = nicknameController.text;
    if (partnerNameDay != null){
      widget.partnerData.nameDay = partnerNameDay;
    }
    // Pass partnerData back to the previous screen when navigating back
    Navigator.pop(context, widget.partnerData);
  }


  void setPartnerBirthday(int day, int month) {
    setState(() {
      partnerNameDay = DateTime(DateTime.now().year, month, day);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    int selectedDay = DateTime.now().day;
    int selectedMonth = DateTime.now().month;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Select Name-day'),
              content: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Day:'),
                      DropdownButton<int>(
                        value: selectedDay,
                        items: List.generate(31, (index) => index + 1)
                            .map((day) => DropdownMenuItem<int>(
                          value: day,
                          child: Text(day.toString()),
                        ))
                            .toList(),
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              selectedDay = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Month:'),
                      DropdownButton<int>(
                        value: selectedMonth,
                        items: List.generate(12, (index) => index + 1)
                            .map((month) => DropdownMenuItem<int>(
                          value: month,
                          child: Text(month.toString()),
                        ))
                            .toList(),
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              selectedMonth = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setPartnerBirthday(selectedDay, selectedMonth);
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Page'),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                  controller: nameController,
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
                  controller: nicknameController,
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
                            partnerNameDay != null
                                ? "${partnerNameDay!.day}/${partnerNameDay!.month}/${partnerNameDay!.year}"
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
                          _selectDate(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Don't celebrate name-day"),
                  value: dontCelebrateNameDay,
                  onChanged: (bool? value) {
                    setState(() {
                      dontCelebrateNameDay = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Don't know the date, please recommend me later"),
                  value: dontKnowDate,
                  onChanged: (bool? value) {
                    setState(() {
                      dontKnowDate = value!;
                    });
                  },
                ),
              ],
            ),
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
                onPressed: goBackWithData,
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
      ),
    );
  }
}
