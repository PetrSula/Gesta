import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/models/Event.dart';

import '../models/partner.dart';
import 'Calendar.dart';

class Frequency extends StatefulWidget {
  final PartnerData partnerData;
  const Frequency({Key? key, required this.partnerData}) : super(key: key);

  @override
  State<Frequency> createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  int frequency = 2;

  void NextScreen() {
    // LinkedHashMap<DateTime, List<Event>> initialEvent = LinkedHashMap();
    // // Adding key-value pairs
    // initialEvent[DateTime(2024, 1, 1)] = [Event('New Year')];
    // initialEvent[DateTime(2024, 2, 14)]= [Event('Valentine\'s Day')];

    // Output:
    // one: 1
    // two: 2
    // three: 3
    Map<DateTime, List<Event>> initialEvents = {
      DateTime.utc(2024, 1, 1): [Event('New Year')],
      DateTime.utc(2024, 2, 14): [Event('Valentine\'s Day')],
      DateTime.utc(2024, 2, 22): [Event('Special Day')],
      DateTime.utc(2024, 1, 8): [Event('Birthday')],
    };

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Calendar(initialEvents: initialEvents),
      ),
    );
  }

  void increaseFrequency() {
    setState(() {
      if (frequency < 8) {
        frequency++;
      }
    });
  }

  void decreaseFrequency() {
    setState(() {
      if (frequency > 0) {
        frequency--;
      }
    });
  }
  void goBackWithData(){
    Navigator.pop(context, widget.partnerData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequency of Reminders'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set Reminder Frequency',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      decreaseFrequency();
                    },
                  ),
                  Text(
                    '$frequency', // Frequency number
                    style: TextStyle(fontSize: 18.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      increaseFrequency();
                    },
                  ),
                ],
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
              onPressed: goBackWithData
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                size: 50.0,
                color: Colors.blue,
              ),
              onPressed: NextScreen,
            ),
          ],
        ),
      ),
    );
  }
}
