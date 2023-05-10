import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF2196F3);
const Color secondaryColor = Color(0xFF0F0E0E);
const Color thirdColor = Color(0xFFF3F3F3);
const Color fourthColor = Color(0xFFFFFFFF);

final customTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: thirdColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
);
