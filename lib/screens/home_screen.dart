import 'package:flutter/material.dart';
import 'package:nepa_issues/utils/settings.dart';
import 'package:nepa_issues/widgets/calendar_widget.dart';
import 'package:nepa_issues/widgets/ledgend.dart';
import 'package:nepa_issues/widgets/pattern_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _startDate = DateTime(2025, 1, 1); // Default start date
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _loadStartDate();
    _selectedDay = _focusedDay;
  }

  Future<void> _loadStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    final startDateMillis = prefs.getInt('startDate');
    
    if (startDateMillis != null) {
      setState(() {
        _startDate = DateTime.fromMillisecondsSinceEpoch(startDateMillis);
      });
    }
  }

  Future<void> _saveStartDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startDate', date.millisecondsSinceEpoch);
  }

  void _showSettingsDialog() {
    showSettingsDialog(
      context: context,
      currentStartDate: _startDate,
      onSaved: (newStartDate) {
        setState(() {
          _startDate = newStartDate;
          _saveStartDate(newStartDate);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final onColor = widget.isDarkMode ? Colors.green[700]! : Colors.green;
    final offColor = widget.isDarkMode ? Colors.red[900]! : Colors.red;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Electricity Calendar'),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
            tooltip: widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
          ),
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
            },
            tooltip: 'Today',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsDialog,
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CalendarWidget(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                startDate: _startDate,
                isDarkMode: widget.isDarkMode,
              ),
            ),
          ),
          const SizedBox(height: 16),
          LegendWidget(
            onColor: onColor,
            offColor: offColor,
            textColor: textColor,
          ),
          const SizedBox(height: 16),
          PatternInfoWidget(
            startDate: _startDate,
            textColor: textColor,
          ),
        ],
      ),
    );
  }
}