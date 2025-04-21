import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatternInfoWidget extends StatelessWidget {
  final DateTime startDate;
  final Color textColor;

  const PatternInfoWidget({
    Key? key,
    required this.startDate,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Pattern: 2 Days ON, 1 Day OFF',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Starting from: ${DateFormat('MMM d, yyyy').format(startDate)}',
              style: TextStyle(
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}