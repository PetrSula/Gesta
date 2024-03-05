import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/first_login/Frequenci.dart'; // Import any required file
import 'package:my_app_2/models/importantEvent.dart';

import '../models/partner.dart';
import 'importantEventsList.dart';

class ImportantEvents extends StatefulWidget {
  final PartnerData partnerData;

  const ImportantEvents({Key? key, required this.partnerData}) : super(key: key);

  @override
  State<ImportantEvents> createState() => _ImportantEventsState();
}

class _ImportantEventsState extends State<ImportantEvents> {
  List<ImportatntEvent> events = [
    ImportatntEvent(nameOfEvent: "Event 1", dateOfEvent: DateTime(2024, 3, 10)),
    ImportatntEvent(nameOfEvent: "Event 2", dateOfEvent: DateTime(2024, 3, 15)),
    ImportatntEvent(nameOfEvent: "Event 5", dateOfEvent: DateTime(2024, 3, 20)),
  ];
  DateTime? eventDate;
  TextEditingController eventNameController = TextEditingController();
  bool _isEditing = false;
  bool _existDate = true;
  AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  int selectedEventIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void removeEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  void nextScreen(BuildContext context) {
    // Navigate to the next screen
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => Frequency(partnerData: widget.partnerData)),
    );
  }

  void goBackWithData() {
    // widget.partnerData.importantEvents = events;
    // Pass partnerData back to the previous screen when navigating back
    Navigator.pop(context, widget.partnerData);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eventDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        eventDate = picked;
        _existDate = true;
      });
    }
  }

  bool checkParameters() {
    // Check if the name field is empty
    FocusScope.of(context).unfocus();
    bool missParametr = false;
    _autovalidateMode= AutovalidateMode.always;
    if (eventNameController.text.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter name of Event.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      _autovalidateMode= AutovalidateMode.always;
      missParametr = true;
    }
    if (eventDate == null ){
      missParametr = true;
      _existDate = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter event date.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      // setState(() {
      //   dateErrorMessage = 'Please select a date';
      // });
    }
    return missParametr;
  }

  void saveChanges() {
    if (checkParameters()) {
      // Show error message or handle the case where either the event name or date is empty
      return;
    }

    setState(() {
      // Update the name and date of the selected event
      events[selectedEventIndex].nameOfEvent = eventNameController.text;
      events[selectedEventIndex].dateOfEvent = eventDate!;
    });

    // Reset input fields
    _clearInputFields();
  }

  void _onEditEvent(int index) {
    selectedEventIndex = index;
    ImportatntEvent event = events[index];
    eventNameController.text = event.nameOfEvent;
    setState(() {
      eventDate = event.dateOfEvent;
      _isEditing = true;
      _existDate = true;
    });
  }

  void _clearInputFields() {
    _autovalidateMode= AutovalidateMode.onUserInteraction;
    eventNameController.clear();
    setState(() {
      eventDate = null;
    });
  }

  void addImportantEvent() {
    if (checkParameters())
      {
        setState(() {
        });
        return;
      }
      // Add the event to the list
      setState(() {
        events.add(ImportatntEvent(
          nameOfEvent: eventNameController.text,
          dateOfEvent: eventDate!,
        ));
      });
      _clearInputFields();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
          title: Text('Choose Important Events'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Important Event',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70.0,
                      child: Row(
                        children: [
                          Container(
                            width: 300.0,
                            child: TextFormField(
                              controller: eventNameController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Event Name',
                              ),
                                autovalidateMode: _autovalidateMode,
                                validator: (value) {
                                  if (value == null || value.isEmpty ){
                                    print("Not valid");
                                    return 'Please enter your name of Event';
                                  }
                                  print("Valid");
                                  return null;
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      height: 60.0,
                      child: Row(
                        children: [
                          Container(
                            width: 300,
                            decoration:  BoxDecoration(
                              border: Border.all(color: _existDate ? Colors.grey[400]! : Theme.of(context).errorColor,),
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
                                    eventDate != null
                                        ? "${eventDate!.day}/${eventDate!.month}/${eventDate!.year}"
                                        : "Select Date",
                                    style: TextStyle(fontSize: 16.0),
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
                    ),
                  ],
                ),
                  SizedBox(height: 20.0),
                  if (_isEditing) // Show only when editing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            saveChanges();
                            setState(() {
                              _isEditing = false; // Reset editing flag
                            });
                          },
                          child: Text('Save Changes'),
                        ),
                      ],
                    ),
                  if (!_isEditing)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: addImportantEvent,
                        child: Text('Add event'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Events List',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  // Display the list of events
                  ImportantEventsList(events: events, onRemoveEvent: removeEvent, onEditEvent: _onEditEvent),
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
                    // Call the function to navigate to the next screen
                    nextScreen(context);
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
