import 'package:flutter/material.dart';

final theme = ThemeData(
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.blue.shade300, padding: const EdgeInsets.all(14),
      //side: const BorderSide(color: Colors.white60),
      //shape: const StadiumBorder(),
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    ),
  ),
);
