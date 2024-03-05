import 'package:flutter/material.dart';
import 'package:my_app_2/models/importantEvent.dart';

class ImportantEventsList extends StatelessWidget {
  final List<ImportatntEvent> events;
  final Function(int) onRemoveEvent;
  final Function(int) onEditEvent;

  ImportantEventsList({required this.events, required this.onRemoveEvent, required this.onEditEvent});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return ListTile(
          title: Text(event.nameOfEvent),
          subtitle: Text(
              '${event.dateOfEvent.day}/${event.dateOfEvent.month}/${event.dateOfEvent.year}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  onEditEvent(index);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  onRemoveEvent(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

