// Import necessary Flutter packages
import 'package:flutter/material.dart'; // Provides core widgets and functionalities for building the UI

/// LegendWidget is a StatelessWidget that displays the legend for the electricity calendar.
class LegendWidget extends StatelessWidget {
  // The color for the "on" state.
  final Color onColor;
  // The color for the "off" state.
  final Color offColor;
  // The color for the text.
  final Color textColor;

  /// Constructor for the LegendWidget.
  /// Requires the onColor, offColor, and textColor parameters.
  const LegendWidget({
    super.key,
    required this.onColor,
    required this.offColor,
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
        child: Row(
          // Row is a widget that arranges its children in a horizontal line.
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute children evenly.
          children: [
            // The children of the row.
            _buildLegendItem(onColor, 'Electricity ON', textColor), // Legend item for "Electricity ON".
            _buildLegendItem(offColor, 'Electricity OFF', textColor), // Legend item for "Electricity OFF".
          ],
        ),
      ),
    );
  }

  /// Builds a legend item.
  /// Each legend item consists of a colored box and a label.
  Widget _buildLegendItem(Color color, String label, Color textColor) {
    return Row(
      children: [
        Container(
          // Container is a widget that can be used to apply styling to its child.
          width: 24, // The width of the container.
          height: 24, // The height of the container.
          decoration: BoxDecoration(
            // BoxDecoration is used to apply styling to the container.
            color: color, // The color of the container.
            borderRadius: BorderRadius.circular(6), // The border radius of the container.
          ),
        ),
        const SizedBox(width: 8), // Empty space.
        Text(
          // Text is a widget that displays text.
          label, // The text to display.
          style: TextStyle(
            // Style for the text.
            fontSize: 16, // The font size of the text.
            fontWeight: FontWeight.w500, // The font weight of the text.
            color: textColor, // The color of the text.
          ),
        ),
      ],
    );
  }
}