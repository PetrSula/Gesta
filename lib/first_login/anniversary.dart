import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/Frequenci.dart';

import '../models/partner.dart';
import 'importantEvents.dart';

class Anniversary extends StatefulWidget {
  final PartnerData partnerData;

  const Anniversary({Key? key, required this.partnerData}) : super(key: key);

  @override
  State<Anniversary> createState() => _AnniversaryState();
}

class _AnniversaryState extends State<Anniversary> {
  DateTime? partnerAnniversary;
  bool recommendLater = false;

  @override
  void initState() {
    super.initState();
    if (widget.partnerData.anniversary != null) {
      setState(() {
        partnerAnniversary = widget.partnerData.anniversary;
      });
    }
  }

  void setPartnerAnniversary(DateTime selectedDate) {
    setState(() {
      partnerAnniversary = selectedDate;
    });
  }

  void nextScreen(BuildContext context) {
    // Navigate to the next screen
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => ImportantEvents(partnerData: widget.partnerData)),
    );
  }

  void goBackWithData() {
    if (partnerAnniversary != null) {
      widget.partnerData.anniversary = partnerAnniversary;
    }
    // Pass partnerData back to the previous screen when navigating back
    Navigator.pop(context, widget.partnerData);
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
        partnerAnniversary = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Anniversary of Partner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Partner\'s Anniversary:',
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
                            partnerAnniversary != null
                                ? "${partnerAnniversary!.day}/${partnerAnniversary!.month}/${partnerAnniversary!.year}"
                                : "Select Anniversary",
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
              onPressed: goBackWithData,
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
