// Import necessary Flutter packages
import 'package:flutter/material.dart'; // Provides core widgets and functionalities for building the UI
import 'package:intl/intl.dart'; // Used for formatting dates

/// PatternInfoWidget is a StatelessWidget that displays information about the electricity usage pattern.
class PatternInfoWidget extends StatelessWidget {
  // The start date of the electricity usage pattern.
  final DateTime startDate;
  // The color for the text.
  final Color textColor;

  /// Constructor for the PatternInfoWidget.
  /// Requires the startDate and textColor parameters.
  const PatternInfoWidget({
    super.key,
    required this.startDate,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    // Card is a widget that displays information in a card-like container.
    return Card(
      elevation: 2, // The elevation of the card.
      margin: const EdgeInsets.symmetric(horizontal: 16), // The margin around the card.
      child: Padding(
        // Padding is a widget that adds padding around its child.
        padding: const EdgeInsets.all(16), // The padding around the child.
        child: Column(
          // Column is a widget that arranges its children in a vertical line.
          children: [
            // The children of the column.
            Text(
              // Text is a widget that displays text.
              'Pattern: 2 Days ON, 1 Day OFF', // The text to display.
              style: TextStyle(
                // Style for the text.
                fontSize: 16, // The font size of the text.
                fontWeight: FontWeight.w500, // The font weight of the text.
                color: textColor, // The color of the text.
              ),
            ),
            const SizedBox(height: 8), // Empty space.
            Text(
              // Text is a widget that displays text.
              'Starting from: ${DateFormat('MMM d, yyyy').format(startDate)}', // The text to display.
              style: TextStyle(
                // Style for the text.
                fontSize: 14, // The font size of the text.
                color: textColor, // The color of the text.
              ),
            ),
          ],
        ),
      ),
    );
  }
}