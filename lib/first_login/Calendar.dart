import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/Event.dart';


class Calendar extends StatefulWidget {
  final Map<DateTime, List<Event>> initialEvents;
  const Calendar({Key? key,required this.initialEvents}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  Map<DateTime,List<Event>> events = {};
  late final ValueNotifier<List<Event>> _selectedEvents;

  List<Event> _getEventsForDay(DateTime day) {
    print("Events for day $day: ${kEvents[day]}");
    // Implementation example
    return events[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    // List<Event> = widget.initialEvents;
    events.addAll(widget.initialEvents);
    print('this are events $events');
    print('this are events $kEvents');
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {

    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Events'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            focusedDay: _focusedDay,
            eventLoader: _getEventsForDay
            ,
            calendarFormat: _calendarFormat,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected:_onDaySelected,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ValueListenableBuilder<List<Event>>
              (valueListenable: _selectedEvents, builder: (context,value,_){
              return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context,index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: ListTile(onTap: ()=>print(""),
                    title: Text('${value[index]}'),
                  ),
                );
              });
            }
            ),
          )
        ],
      ),
    );
  }
}
