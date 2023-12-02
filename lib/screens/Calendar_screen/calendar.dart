import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(CalendarPage());
}

class CalendarPage extends StatefulWidget {
  static String routeName = 'CalendarPage';
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<dynamic>> _events = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Seminar Hall Booking Calendar'),
          backgroundColor: Color(0xFF345FB4), // Primary color
        ),
        body: Column(
          children: [
            TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                _showSeminarHallPopup(context);
              },
              eventLoader: (day) {
                return _events[day] ?? [];
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF6789CA), // Secondary color for selected date
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(color: Colors.black),
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(fontSize: 20.0),
                formatButtonVisible: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSeminarHallPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seminar Hall for ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Implement your booking widget here.'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Logic to update the booked date in _events map
                    _events[_selectedDay] = ['Booked'];
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Book Seminar Hall'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}