import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSettingsDialog({
  required BuildContext context,
  required DateTime currentStartDate,
  required Function(DateTime) onSaved,
}) {
  DateTime tempStartDate = currentStartDate;
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select the start date of the electricity pattern:'),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: Text(DateFormat('MMM d, yyyy').format(tempStartDate)),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: tempStartDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      setState(() {
                        tempStartDate = picked;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'The selected date will be treated as the first "ON" day in the 2-ON, 1-OFF pattern.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  onSaved(tempStartDate);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      );
    },
  );
}