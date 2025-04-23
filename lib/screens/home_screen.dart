// Import necessary Flutter packages
import 'package:flutter/material.dart'; // Provides core widgets and functionalities for building the UI
import 'package:nepa_issues/utils/settings.dart'; // Imports settings utility functions
import 'package:nepa_issues/widgets/calendar_widget.dart'; // Imports the calendar widget
import 'package:nepa_issues/widgets/ledgend.dart'; // Imports the legend widget
import 'package:nepa_issues/widgets/pattern_info.dart'; // Imports the pattern info widget
import 'package:shared_preferences/shared_preferences.dart'; // Used for storing simple data persistently across app restarts
import 'package:table_calendar/table_calendar.dart'; // Imports the table calendar package

/// HomePage is a StatefulWidget that displays the electricity calendar.
class HomePage extends StatefulWidget {
  // Indicates whether the app is in dark mode.
  final bool isDarkMode;
  // Callback function to toggle the theme.
  final VoidCallback toggleTheme;

  /// Constructor for the HomePage widget.
  /// Requires the isDarkMode flag and the toggleTheme callback.
  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

    /// Creates the mutable state for this widget.
    /// Flutter calls this method when it needs to create a new state for the widget.
    @override
    State<HomePage> createState() => _HomePageState();
  }

/// _HomePageState is the state associated with the HomePage widget.
/// It manages the calendar's state, including the focused day, selected day, start date, and calendar format.
class _HomePageState extends State<HomePage> {
  // The currently focused day in the calendar.
  DateTime _focusedDay = DateTime.now();
  // The currently selected day in the calendar.
  DateTime? _selectedDay;
  // The start date of the electricity usage pattern.
  DateTime _startDate = DateTime(2025, 1, 1); // Default start date
  // The format of the calendar (month, week, two weeks).
  late CalendarFormat _calendarFormat;

  /// Initializes the state of the HomePage widget.
  /// This method is called once when the widget is first created.
  @override
  void initState() {
    super.initState(); // Call the initState method of the parent class.
    _calendarFormat = CalendarFormat.month; // Set the initial calendar format to month.
    _loadStartDate(); // Load the start date from shared preferences.
    _selectedDay = _focusedDay; // Initialize the selected day to the focused day.
  }

    /// Loads the start date from shared preferences.
    /// This method retrieves the start date from shared preferences, if it exists.
    Future<void> _loadStartDate() async {
      final prefs = await SharedPreferences.getInstance(); // Obtain an instance of SharedPreferences.
      final startDateMillis = prefs.getInt('startDate'); // Get the start date in milliseconds since epoch.
  
      // If the start date exists in shared preferences.
      if (startDateMillis != null) {
        setState(() {
          // Update the state with the loaded start date.
          _startDate = DateTime.fromMillisecondsSinceEpoch(startDateMillis);
        });
      }
    }

    /// Saves the start date to shared preferences.
    /// This method saves the start date to shared preferences.
    Future<void> _saveStartDate(DateTime date) async {
      final prefs = await SharedPreferences.getInstance(); // Obtain an instance of SharedPreferences.
      await prefs.setInt('startDate', date.millisecondsSinceEpoch); // Save the start date in milliseconds since epoch.
    }

    /// Shows the settings dialog.
    /// This method displays a dialog that allows the user to change the start date.
    void _showSettingsDialog() {
      showSettingsDialog(
        context: context, // The build context.
        currentStartDate: _startDate, // The current start date.
        onSaved: (newStartDate) {
          // Callback function when the user saves the new start date.
          setState(() {
            // Update the state with the new start date.
            _startDate = newStartDate;
            _saveStartDate(newStartDate); // Save the new start date to shared preferences.
          });
        },
      );
    }

    /// Builds the widget.
    /// This method builds the UI for the HomePage widget.
    @override
    Widget build(BuildContext context) {
      // Determine the colors based on the current theme mode.
      final onColor = widget.isDarkMode ? Colors.green[700]! : Colors.green;
      final offColor = widget.isDarkMode ? Colors.red[900]! : Colors.red;
      final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
  
      // Scaffold is the base widget for a screen.
      return Scaffold(
        appBar: AppBar(
          // AppBar is the top bar of the screen.
          title: const Text('Electricity Calendar'), // The title of the app bar.
          elevation: 2, // The elevation of the app bar.
          actions: [
            // Actions are the buttons on the right side of the app bar.
            IconButton(
              // Button to toggle the theme.
              icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode), // The icon of the button.
              onPressed: widget.toggleTheme, // The callback function when the button is pressed.
              tooltip: widget.isDarkMode ? 'Light Mode' : 'Dark Mode', // The tooltip of the button.
            ),
            IconButton(
              // Button to navigate to today's date.
              icon: const Icon(Icons.today), // The icon of the button.
              onPressed: () {
                // Callback function when the button is pressed.
                setState(() {
                  // Update the state to navigate to today's date.
                  _focusedDay = DateTime.now();
                  _selectedDay = DateTime.now();
                });
              },
              tooltip: 'Today', // The tooltip of the button.
            ),
            IconButton(
              // Button to open the settings dialog.
              icon: const Icon(Icons.settings), // The icon of the button.
              onPressed: _showSettingsDialog, // The callback function when the button is pressed.
              tooltip: 'Settings', // The tooltip of the button.
            ),
          ],
        ),
        body: Column(
          // Column is a widget that arranges its children in a vertical line.
          children: [
            Card(
              // Card is a widget that displays information in a card-like container.
              margin: const EdgeInsets.all(8.0), // The margin around the card.
              elevation: 4, // The elevation of the card.
              child: Padding(
                // Padding is a widget that adds padding around its child.
                padding: const EdgeInsets.all(8.0), // The padding around the child.
                child: CalendarWidget(
                  // The calendar widget.
                  focusedDay: _focusedDay, // The currently focused day.
                  selectedDay: _selectedDay, // The currently selected day.
                  calendarFormat: _calendarFormat, // The format of the calendar.
                  onDaySelected: (selectedDay, focusedDay) {
                    // Callback function when a day is selected.
                    setState(() {
                      // Update the state with the selected day.
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    // Callback function when the calendar format is changed.
                    setState(() {
                      // Update the state with the new calendar format.
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    // Callback function when the calendar page is changed.
                    _focusedDay = focusedDay;
                  },
                  startDate: _startDate, // The start date of the electricity usage pattern.
                  isDarkMode: widget.isDarkMode, // Whether the app is in dark mode.
                ),
              ),
            ),
            const SizedBox(height: 16), // Empty space.
            LegendWidget(
              // The legend widget.
              onColor: onColor, // The color for the "on" state.
              offColor: offColor, // The color for the "off" state.
              textColor: textColor, // The color for the text.
            ),
            const SizedBox(height: 16), // Empty space.
            PatternInfoWidget(
              // The pattern info widget.
              startDate: _startDate, // The start date of the electricity usage pattern.
              textColor: textColor, // The color for the text.
            ),
          ],
        ),
      );
    }
  }