// Import necessary Flutter packages
import 'package:flutter/material.dart'; // Provides core widgets and functionalities for building the UI
import 'package:nepa_issues/screens/home_screen.dart'; // Imports the home screen of the application
import 'package:shared_preferences/shared_preferences.dart'; // Used for storing simple data persistently across app restarts


/// Main entry point for the application.
/// This function is called when the app starts.
void main() {
  // runApp is a Flutter function that inflates the given widget and attaches it to the screen.
  runApp(const MyApp()); // MyApp is the root widget of our application.
}

/// MyApp is the root widget of the application.
/// It extends StatefulWidget because the theme can change dynamically.
class MyApp extends StatefulWidget {
  // Key for the widget (optional, but good practice for stateful widgets).
  const MyApp({super.key});

  /// Creates the mutable state for this widget.
  /// Flutter calls this method when it needs to create a new state for the widget.
  @override
  State<MyApp> createState() => _MyAppState();
}

/// _MyAppState is the state associated with the MyApp widget.
/// It manages the application's theme mode (light or dark).
class _MyAppState extends State<MyApp> {
  // A boolean variable to track whether the app is in dark mode.
  bool _isDarkMode = false;

  /// Initializes state and loads saved theme preference.
  /// This method is called once when the widget is first created.
  @override
  void initState() {
    super.initState(); // Call the initState method of the parent class.
    _loadThemePreference(); // Load the user's preferred theme mode from shared preferences.
  }

    /// Loads theme preference from persistent storage.
    /// This method retrieves the user's preferred theme mode from shared preferences.
    Future<void> _loadThemePreference() async {
      final prefs = await SharedPreferences.getInstance(); // Obtain an instance of SharedPreferences.
      setState(() {
        // Update the state with the loaded theme mode.
        // If 'isDarkMode' is not found in shared preferences, default to false (light mode).
        _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      });
    }

    /// Persists theme preference to storage.
    /// This method saves the user's preferred theme mode to shared preferences.
    Future<void> _saveThemePreference(bool isDark) async {
      final prefs = await SharedPreferences.getInstance(); // Obtain an instance of SharedPreferences.
      await prefs.setBool('isDarkMode', isDark); // Save the 'isDarkMode' value to shared preferences.
    }

    /// Toggles between dark/light theme modes.
    /// This method is called when the user wants to switch between dark and light mode.
    void _toggleTheme() {
      setState(() {
        // Toggle the _isDarkMode value.
        _isDarkMode = !_isDarkMode;
        _saveThemePreference(_isDarkMode); // Save the new theme mode to shared preferences.
      });
    }

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the base widget for Flutter applications.
    return MaterialApp(
      title: 'Electricity Calendar', // The title of the application.
      theme: ThemeData(
        // ThemeData defines the visual appearance of the application in light mode.
        colorScheme: ColorScheme.fromSeed(
          // ColorScheme is used to define the color palette for the application.
          seedColor: Colors.blue, // The primary color of the application.
          brightness: _isDarkMode ? Brightness.dark : Brightness.light, // Set brightness based on _isDarkMode
        ),
        useMaterial3: true, // Enable Material 3 design.
      ),
      darkTheme: ThemeData(
        // ThemeData defines the visual appearance of the application in dark mode.
        colorScheme: ColorScheme.fromSeed(
          // ColorScheme is used to define the color palette for the application.
          seedColor: Colors.blue, // The primary color of the application.
          brightness: Brightness.dark,
        ),
        useMaterial3: true, // Enable Material 3 design.
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light, // Use dark or light theme based on _isDarkMode.
      home: HomePage(
        // The home screen of the application.
        isDarkMode: _isDarkMode, // Pass the current theme mode to the home screen.
        toggleTheme: _toggleTheme, // Pass the theme toggle function to the home screen.
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner in the top right corner.
    );
  }
}