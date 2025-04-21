import 'package:flutter/material.dart';
import 'package:nepa_issues/widgets/electricity_calculator.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;
  final DateTime startDate;
  final bool isDarkMode;

  const CalendarWidget({
    Key? key,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    required this.startDate,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onColor = isDarkMode ? Colors.green[700]! : Colors.green;
    final offColor = isDarkMode ? Colors.red[900]! : Colors.red;

    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: onDaySelected,
      onFormatChanged: onFormatChanged,
      onPageChanged: onPageChanged,
      headerStyle: HeaderStyle(
        formatButtonTextStyle: const TextStyle().copyWith(fontSize: 14),
        titleCentered: true,
        formatButtonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return _buildCalendarDay(day, onColor, offColor);
        },
        selectedBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: hasElectricity(day, startDate) ? onColor : offColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
            ),
            child: Center(
              child: Text(
                '${day.day}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: hasElectricity(day, startDate) ? onColor : offColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Center(
              child: Text(
                '${day.day}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        defaultTextStyle: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black87,
        ),
        weekendTextStyle: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCalendarDay(DateTime day, Color onColor, Color offColor) {
    final bool hasElec = hasElectricity(day, startDate);
    final Color bgColor = hasElec ? onColor.withOpacity(0.9) : offColor.withOpacity(0.9);
    
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}