import 'package:flutter/material.dart';
class AppGradients {
  static final LinearGradient yellowToPink = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFFFDF00), // Yellow
      Color(0xFFFDBCD0), // Pink
    ],
    stops: [0.0, 1.0], // Optional, but you can tweak for -5.3% if needed
    transform: GradientRotation(89 * 3.14159265 / 180), // Convert degrees to radians
  );
}