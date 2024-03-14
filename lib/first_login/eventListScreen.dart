import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app_2/models/importantEvent.dart';

import '../models/partner.dart';
import '../models/showEvent.dart';

class EventListScreen extends StatefulWidget {
  final PartnerData partnerData;

  const EventListScreen({Key? key, required this.partnerData}) : super(key: key);

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<ShowEvent> events = [];

  @override
  void initState(){
    super.initState();
    events = fillEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          Color tileColor = _getColorForType(event.type);

          return ListTile(
            title: Text(events[index].name),
            subtitle: Text(_formatDate(events[index].date)),
            tileColor: tileColor,
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _removeEvent(index);
                });
              }
            )
          );
        },
      ),
    );
  }

  List<ShowEvent> fillEvents() {
    addBaseEvents();
    if (widget.partnerData.birthDay != null) {
      events.add(birthday());
    }
    if (widget.partnerData.nameDay != null){
      events.add(nameDay());
    }
    if (widget.partnerData.anniversary!= null){
      events.add(anniversary());
    }
    if (widget.partnerData.importantEvents != null){
      events.addAll(importantEvents());
    }

  return events;
  }

  ShowEvent birthday() {
    ShowEvent birthday = ShowEvent(
        name: 'Birthday', date: widget.partnerData.birthDay!, type: 0);
    return birthday;
  }

  ShowEvent nameDay() {
    ShowEvent nameDay = ShowEvent(
        name: 'NameDay', date: widget.partnerData.nameDay!, type: 1);
    return nameDay;
  }

  ShowEvent anniversary() {
    ShowEvent anniversary = ShowEvent(
        name: 'Anniversary', date: widget.partnerData.nameDay!, type: 2);
    return anniversary;
  }

  Iterable<ShowEvent> importantEvents() {
    List<ShowEvent> events = [];
    List<ImportantEvent> importantEvent = widget.partnerData.importantEvents!;
    ImportantEvent i;

    for (i in importantEvent) {

      ShowEvent showEvent = ShowEvent(
        name: i.eventName,
        date: i.eventDate,
        type: 3, // Set the appropriate type value
      );
      events.add(showEvent);
    }

    return events;

  }
  String _formatDate(DateTime date) {
    return DateFormat('dd-MM').format(date);
  }
  void _removeEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  Color _getColorForType(int type) {
    switch (type) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.purple;
      case 4:
        return Colors.pink;
      default:
        return Colors.grey; // Default color for unknown types
    }
  }

  void addBaseEvents() {
    ShowEvent valentDay = ShowEvent(
      name: "Valentine's day",
      date: DateTime(DateTime.now().year, 2, 14),
      type: 4, // Set the appropriate type value
    );
    events.add(valentDay);
    ShowEvent IWD = ShowEvent(
        name: "International Women's Day ",
        date: DateTime(DateTime.now().year, 3, 8),
        type: 4);
    events.add(IWD);

  }
}
