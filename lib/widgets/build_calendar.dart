// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// Widget _buildCalendar(onColor, Color offColor, DateTime _focusedDay, CalendarFormat _calendarFormat, DateTime? _selectedDay) {
//     return TableCalendar(
//       firstDay: DateTime.utc(2023, 1, 1),
//       lastDay: DateTime.utc(2030, 12, 31),
//       focusedDay: _focusedDay,
//       calendarFormat: _calendarFormat,
//       selectedDayPredicate: (day) {
//         return isSameDay(_selectedDay, day);
//       },
//       onDaySelected: (selectedDay, focusedDay) {
//         setState(() {
//           _selectedDay = selectedDay;
//           _focusedDay = focusedDay;
//         });
//       },
//       onFormatChanged: (format) {
//         setState(() {
//           _calendarFormat = format;
//         });
//       },
//       onPageChanged: (focusedDay) {
//         _focusedDay = focusedDay;
//       },
//       headerStyle: HeaderStyle(
//         formatButtonTextStyle: const TextStyle().copyWith(fontSize: 14),
//         titleCentered: true,
//         formatButtonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Theme.of(context).colorScheme.primary),
//         ),
//       ),
//       calendarBuilders: CalendarBuilders(
//         defaultBuilder: (context, day, focusedDay) {
//           return _buildCalendarDay(day, onColor, offColor);
//         },
//         selectedBuilder: (context, day, focusedDay) {
//           return Container(
//             margin: const EdgeInsets.all(4.0),
//             decoration: BoxDecoration(
//               color: hasElectricity(day) ? onColor : offColor,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
//             ),
//             child: Center(
//               child: Text(
//                 '${day.day}',
//                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           );
//         },
//         todayBuilder: (context, day, focusedDay) {
//           return Container(
//             margin: const EdgeInsets.all(4.0),
//             decoration: BoxDecoration(
//               color: hasElectricity(day) ? onColor : offColor,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.blue, width: 2),
//             ),
//             child: Center(
//               child: Text(
//                 '${day.day}',
//                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           );
//         },
//       ),
//       calendarStyle: CalendarStyle(
//         outsideDaysVisible: true,
//         defaultTextStyle: TextStyle(
//           color: widget.isDarkMode ? Colors.white70 : Colors.black87,
//         ),
//         weekendTextStyle: TextStyle(
//           color: widget.isDarkMode ? Colors.white70 : Colors.black87,
//         ),
//       ),
//     );
//   }