import 'dart:math';

import 'package:flutter/material.dart';

Color generateRandomSoftColor() {
  Random random = Random();

  // Generate random pastel colors by limiting the intensity of each channel.
  int red = 128 + random.nextInt(128); // 128 to 255
  int green = 128 + random.nextInt(128); // 128 to 255
  int blue = 128 + random.nextInt(128); // 128 to 255

  return Color.fromARGB(255, red, green, blue);
}

Color getContrastingTextColor(Color backgroundColor) {
  // Calculate the relative luminance of the background color.
  final luminance = (0.299 * backgroundColor.red +
          0.587 * backgroundColor.green +
          0.114 * backgroundColor.blue) /
      255;

  // Choose either black or white text color based on the luminance.
  return luminance > 0.5 ? Colors.black : Colors.white;
}