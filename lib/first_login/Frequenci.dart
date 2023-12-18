import 'package:flutter/material.dart';

class Frequency extends StatefulWidget {
  const Frequency({super.key});

  @override
  State<Frequency> createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  int frequency = 2;

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
                // nextScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
