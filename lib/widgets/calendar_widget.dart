// Import necessary Flutter packages
import 'package:flutter/material.dart'; // Provides core widgets and functionalities for building the UI
import 'package:nepa_issues/widgets/electricity_calculator.dart'; // Imports the electricity calculator widget
import 'package:table_calendar/table_calendar.dart'; // Imports the table calendar package

/// CalendarWidget is a StatelessWidget that displays the electricity calendar.
class CalendarWidget extends StatelessWidget {
  // The currently focused day in the calendar.
  final DateTime focusedDay;
  // The currently selected day in the calendar.
  final DateTime? selectedDay;
  // The format of the calendar (month, week, two weeks).
  final CalendarFormat calendarFormat;
  // Callback function when a day is selected.
  final Function(DateTime, DateTime) onDaySelected;
  // Callback function when the calendar format is changed.
  final Function(CalendarFormat) onFormatChanged;
  // Callback function when the calendar page is changed.
  final Function(DateTime) onPageChanged;
  // The start date of the electricity usage pattern.
  final DateTime startDate;
  // Indicates whether the app is in dark mode.
  final bool isDarkMode;

  /// Constructor for the CalendarWidget.
  /// Requires all the parameters to be passed in.
  const CalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    required this.startDate,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the colors based on the current theme mode.
    final onColor = isDarkMode ? Colors.green[700]! : Colors.green;
    final offColor = isDarkMode ? Colors.red[900]! : Colors.red;

    // TableCalendar is the main widget for displaying the calendar.
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1), // The first day of the calendar.
      lastDay: DateTime.utc(2030, 12, 31), // The last day of the calendar.
      focusedDay: focusedDay, // The currently focused day.
      calendarFormat: calendarFormat, // The format of the calendar.
      selectedDayPredicate: (day) {
        // Predicate to determine if a day is selected.
        return isSameDay(selectedDay, day);
      },
      onDaySelected: onDaySelected, // Callback function when a day is selected.
      onFormatChanged: onFormatChanged, // Callback function when the calendar format is changed.
      onPageChanged: onPageChanged, // Callback function when the calendar page is changed.
      headerStyle: HeaderStyle(
        // Style for the calendar header.
        formatButtonTextStyle: const TextStyle().copyWith(fontSize: 14), // Style for the format button text.
        titleCentered: true, // Whether the title is centered.
        formatButtonDecoration: BoxDecoration(
          // Decoration for the format button.
          borderRadius: BorderRadius.circular(16), // Border radius of the button.
          border: Border.all(color: Theme.of(context).colorScheme.primary), // Border of the button.
        ),
      ),
      calendarBuilders: CalendarBuilders(
        // Builders for the calendar cells.
        defaultBuilder: (context, day, focusedDay) {
          // Builder for the default calendar cells.
          return _buildCalendarDay(day, onColor, offColor);
        },
        selectedBuilder: (context, day, focusedDay) {
          // Builder for the selected calendar cell.
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
          // Builder for the today calendar cell.
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
        // Style for the calendar.
        outsideDaysVisible: true, // Whether to show the days outside the current month.
        defaultTextStyle: TextStyle(
          // Style for the default text.
          color: isDarkMode ? Colors.white70 : Colors.black87,
        ),
        weekendTextStyle: TextStyle(
          // Style for the weekend text.
          color: isDarkMode ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }

  /// Builds a calendar day cell.
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