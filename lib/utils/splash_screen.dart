// Import necessary Flutter packages
import 'dart:async'; // Provides Timer for delayed navigation
import 'package:flutter/material.dart'; // Provides core widgets and functionalities for building the UI
import 'package:nepa_issues/screens/home_screen.dart'; // Imports the home screen of the application
 
/// SplashScreen is a StatefulWidget that displays a splash screen with an animation.
class SplashScreen extends StatefulWidget {
  // Indicates whether the app is in dark mode.
  final bool isDarkMode;
  // Callback function to toggle the theme.
  final VoidCallback toggleTheme;

  /// Constructor for the SplashScreen widget.
  /// Requires the isDarkMode flag and the toggleTheme callback.
  const SplashScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// _SplashScreenState is the state associated with the SplashScreen widget.
/// It manages the animation and navigation to the home screen.
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Animation controller for the fade-in animation.
  late AnimationController _animationController;
  // Animation for the fade-in effect.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller.
    _animationController = AnimationController(
      vsync: this, // Use the current state as the vsync.
      duration: const Duration(milliseconds: 1500), // Set the duration of the animation.
    );
    // Create a curved animation.
    _animation = CurvedAnimation(
      parent: _animationController, // Set the parent of the animation.
      curve: Curves.easeInOut, // Set the curve of the animation.
    );
    // Start the animation.
    _animationController.forward();
    
    // After 2 seconds, navigate to the home screen.
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            isDarkMode: widget.isDarkMode,
            toggleTheme: widget.toggleTheme,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    // Dispose of the animation controller to release resources.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is the base widget for a screen.
    return Scaffold(
      body: Center(
        // Center the content on the screen.
        child: FadeTransition(
          // FadeTransition applies a fade-in animation.
          opacity: _animation, // Use the animation for the opacity.
          child: Column(
            // Column is a widget that arranges its children in a vertical line.
            mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically.
            children: [
              // The children of the column.
              Icon(
                // Icon is a widget that displays an icon.
                Icons.electric_bolt, // The icon to display.
                size: 100, // The size of the icon.
                color: Theme.of(context).colorScheme.primary, // The color of the icon.
              ),
              const SizedBox(height: 24), // Empty space.
              Text(
                // Text is a widget that displays text.
                'Electricity Calendar', // The text to display.
                style: TextStyle(
                  // Style for the text.
                  fontSize: 28, // The font size of the text.
                  fontWeight: FontWeight.bold, // The font weight of the text.
                  color: Theme.of(context).colorScheme.primary, // The color of the text.
                ),
              ),
              const SizedBox(height: 12), // Empty space.
              Text(
                // Text is a widget that displays text.
                '2-ON, 1-OFF Pattern Tracker', // The text to display.
                style: TextStyle(
                  // Style for the text.
                  fontSize: 16, // The font size of the text.
                  color: Theme.of(context).colorScheme.secondary, // The color of the text.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}