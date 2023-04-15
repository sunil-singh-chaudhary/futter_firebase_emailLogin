import 'package:flutter/material.dart';

class ShowSnackBar {
  // Show a custom Snackbar at the bottom of the screen
  static showCustomSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        animation: ProxyAnimation(),
        content: Text(message,
            style: const TextStyle(color: Colors.white, fontSize: 15)),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating, // Set the behavior to floating
        margin: const EdgeInsets.only(bottom: 60), // Adjust the bottom margin
        shape: RoundedRectangleBorder(
          // Apply custom shape to Snackbar
          borderRadius: BorderRadius.circular(10),
        ),
        // You can customize other properties of the Snackbar, such as duration, action, etc. as needed
      ),
    );
  }
}
