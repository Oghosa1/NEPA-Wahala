// Import necessary Flutter packages
import 'package:flutter/material.dart'; // Provides core widgets and functionalities for building the UI
import 'package:intl/intl.dart'; // Used for formatting dates

/// Shows the settings dialog.
///
/// This dialog allows the user to select the start date of the electricity pattern.
///
/// Args:
///   context (BuildContext): The build context.
///   currentStartDate (DateTime): The current start date.
///   onSaved (Function(DateTime)): Callback function when the user saves the new start date.
void showSettingsDialog({
  required BuildContext context,
  required DateTime currentStartDate,
  required Function(DateTime) onSaved,
}) {
  // A temporary variable to hold the selected start date.
  DateTime tempStartDate = currentStartDate;
  
  // Show the dialog.
  showDialog(
    context: context, // The build context.
    builder: (BuildContext context) {
      // Use StatefulBuilder to manage the state of the dialog.
      return StatefulBuilder(
        builder: (context, setState) {
          // AlertDialog is the base widget for the dialog.
          return AlertDialog(
            title: const Text('Settings'), // The title of the dialog.
            content: Column(
              // Column is a widget that arranges its children in a vertical line.
              mainAxisSize: MainAxisSize.min, // Minimize the size of the column.
              children: [
                // The children of the column.
                const Text('Select the start date of the electricity pattern:'), // A text message.
                const SizedBox(height: 16), // Empty space.
                ElevatedButton(
                  // ElevatedButton is a button with a raised appearance.
                  child: Text(DateFormat('MMM d, yyyy').format(tempStartDate)), // The text of the button.
                  onPressed: () async {
                    // Callback function when the button is pressed.
                    final DateTime? picked = await showDatePicker(
                      // Show the date picker dialog.
                      context: context, // The build context.
                      initialDate: tempStartDate, // The initial date.
                      firstDate: DateTime(2020), // The first date that can be selected.
                      lastDate: DateTime(2030), // The last date that can be selected.
                    );
                    // If a date was picked.
                    if (picked != null) {
                      setState(() {
                        // Update the state with the selected date.
                        tempStartDate = picked;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16), // Empty space.
                const Text(
                  // Text is a widget that displays text.
                  'The selected date will be treated as the first "ON" day in the 2-ON, 1-OFF pattern.', // A text message.
                  textAlign: TextAlign.center, // Align the text to the center.
                ),
              ],
            ),
            actions: [
              // Actions are the buttons at the bottom of the dialog.
              TextButton(
                // TextButton is a button with a flat appearance.
                child: const Text('Cancel'), // The text of the button.
                onPressed: () {
                  // Callback function when the button is pressed.
                  Navigator.of(context).pop(); // Close the dialog.
                },
              ),
              TextButton(
                // TextButton is a button with a flat appearance.
                child: const Text('Save'), // The text of the button.
                onPressed: () {
                  // Callback function when the button is pressed.
                  onSaved(tempStartDate); // Call the onSaved callback function.
                  Navigator.of(context).pop(); // Close the dialog.
                },
              ),
            ],
          );
        }
      );
    },
  );
}